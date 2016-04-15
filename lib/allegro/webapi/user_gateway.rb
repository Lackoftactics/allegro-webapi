module Allegro
  module WebApi
    class UserGateway
      attr_reader :client

      USER_METHODS = %w(first_name last_name company birth_date email phone
                        address city)
      USER_COMPANY_METHODS = %w(regon nip)

      def initialize(client)
        @client = client
      end

      def self.call(client)
        new(client).do_get_my_data
      end

      def do_get_my_data
        params = { session_handle: client.session_handle }
        @my_data = client.call(:do_get_my_data, message: params)
                         .body[:do_get_my_data_response]
        self
      end

      # it creates methods: first_name last_name company birth_date email phone
      #                     address city
      USER_METHODS.each do |method_name|
        define_method(method_name) do
          @my_data[:user_data]["user_#{method_name}".to_sym]
        end
      end

      # it creates methods: regon, nip
      USER_COMPANY_METHODS.each do |method_name|
        define_method(method_name) do
          @my_data[:company_extra_data]["company_#{method_name}".to_sym]
        end
      end
    end # class User
  end # module WebApi
end # module Allegro
