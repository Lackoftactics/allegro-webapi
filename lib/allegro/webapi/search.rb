# frozen_string_literal: true
module Allegro
  module WebApi
    class Search
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def search_query(search_string, options = {})
        message = {session_handle: client.session_handle,
                   search_query: {search_string: search_string}.merge(options)}
        client.call(:do_search, message: message).body
      end
    end # class Search
  end # module WebApi
end # module Allegro
