# frozen_string_literal: true
module Allegro
  module WebApi
    class UserGateway
      attr_reader :client

      USER_METHODS = %w(id first_name last_name company birth_date email phone
                        address city).freeze
      USER_COMPANY_METHODS = %w(regon nip).freeze

      def initialize(client)
        @client = client
      end

      def self.call(client)
        new(client).do_get_my_data
      end

      def do_get_my_data
        message = { session_handle: client.session_handle }
        @my_data = client.call(Call.new(:do_get_my_data, message: message))
          .body[:do_get_my_data_response]
        self
      end

      # it creates methods: id first_name last_name company birth_date email
      #                     phone address city id
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
    end # class UserGateway
  end # module WebApi
end # module Allegro
