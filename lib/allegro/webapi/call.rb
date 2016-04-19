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
      attr_reader :raw_data, :request_params, :error

      def initialize(opts)
        @error = opts[:error]
        @raw_data = opts[:raw_data]
        @request_params = opts[:request_params]
        super(opts)
      end

      def self.call(error, request_params, raw_data)
        new(error: error, request_params: request_params, raw_data: raw_data)
      end
    end # class Error
  end # module WebApi
end # module Allegro
