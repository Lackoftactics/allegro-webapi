module Allegro
  module WebApi
    class PayuGateway

      def initialize(client)
        @client = client
      end

      def self.call(client)
        new(client).payments_info
      end

      def payments_info
        message = { session_id: @client.session_handle }
        @my_data =
          @client.call(Call.new(:do_get_my_payments_info, message: message))
                 .body[:do_get_my_payments_info_response][:payments_info]
        self
      end

      def bank_account
        @my_data[:payments_bank_account]
      end
    end # class PayuGateway
  end # module WebApi
end # module Allegro
