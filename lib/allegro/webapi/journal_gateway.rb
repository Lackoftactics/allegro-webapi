# frozen_string_literal: true
module Allegro
  module WebApi
    class JournalGateway
      attr_reader :client, :my_data, :last_row_id

      def initialize(client)
        @client = client
      end

      def since(last_row_id = nil)
        message = if last_row_id.present?
                    args_with_starting_point(last_row_id)
                  else
                    args
                  end
        client.call(:do_get_site_journal, message: message)
              .body[:do_get_site_journal_response][:site_journal_array][:item]
      end

      def items_info_for(array)
        message = {
          session_handle: client.session_handle,
          items_id_array: {item: array},
        }
        client.call(:do_get_items_info, message: message)
              .body[:do_get_items_info_response][:array_item_list_info][:item]
      end

      private

      def args_with_starting_point(last_row_id)
        {
          session_handle: client.session_handle,
          starting_point: last_row_id,
          info_type: 1,
        }
      end

      def args
        {
          session_handle: client.session_handle,
          info_type: 1,
        }
      end
    end # class JournalGateway
  end # module WebApi
end # module Allegro
