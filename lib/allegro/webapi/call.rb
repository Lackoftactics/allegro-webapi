module Allegro
  module WebApi
    class Call
      attr_reader :operation_name, :locals, :counter
      def initialize(operation_name, locals = {})
        @operation_name = operation_name
        @locals = locals
        @counter = 0
      end

      def increment_counter
        @counter += 1
      end

      def raw_data_for(client)
        @raw_data = client.call(operation_name, locals)
      end

      def raise_error(error)
        raise Error.call(error, locals, @raw_data)
      end
    end # class Call

    class Error < StandardError
      ERROR_CODES = {'ERR_NEW_PAYMENTS_NOT_CONFIGURED' => '405'}

      attr_reader :raw_data, :request_params, :error, :code

      def initialize(opts)
        @error = opts[:error]
        @raw_data = opts[:raw_data]
        @request_params = opts[:request_params]
        @code = ERROR_CODES[error.to_hash.dig(:fault, :faultcode)] || '500'
        super(opts)
      end

      def self.call(error, request_params, raw_data)
        new(error: error, request_params: request_params, raw_data: raw_data)
      end
    end # class Error
  end # module WebApi
end # module Allegro
