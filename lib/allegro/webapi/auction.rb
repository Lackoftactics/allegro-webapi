# frozen_string_literal: true
module Allegro
  module WebApi
    class Auction
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # fields for form
      # Helpful for building forms
      def do_get_sell_form_fields
        message = {country_code: client.country_code,
                   local_version: client.local_version,
                   webapi_key: client.webapi_key}
        client.call(:do_get_sell_form_fields, message: message)
      end

      # def do_check_new_auction_ext(*fields)
      #
      # end
      #
      # def do_new_auction_ext
      #
      #
      # end
    end # class Auction
  end # module WebApi
end # module Allegro
