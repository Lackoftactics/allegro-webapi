module Allegro
  module WebApi
    class User
      attr_reader :client
      attr_reader :my_data

      def initialize(client)
        @client = client
      end

      def do_get_my_data
        @my_data = client.call(:do_get_my_data, message: {session_handle: client.session_handle}).
            body[:do_get_my_data_response][:user_data]
      end

      def company
        my_data[:user_company]
      end

      def id
        my_data[:user_id]
      end

      def rating
        my_data[:user_rating]
      end

      def email
        my_data[:user_email]
      end

      def phone
        my_data[:user_phone]
      end


      def birth_date
        my_data[:user_birth_date]
      end

      def address
        my_data[:user_address]
      end

      def city
        my_data[:user_city]
      end

      def first_name
        my_data[:user_first_name]
      end

      def last_name
        my_data[:user_last_name]
      end

    end
  end
end