#
# Base Optin Integration
#
module IntegrateMe
  module Optin
    class Base
      # @!attribute [r] api_key
      #   @return [String]
      attr_accessor :api_key

      # @!attribute [r] api_token
      #   @return [String]
      attr_accessor :api_token

      # @!attribute [r] contact
      #   @return [String]
      attr_accessor :contact

      # @!attribute [r] list
      #   @return [String]
      attr_accessor :list

      #
      # Initialises an integration
      #
      # @params api_key [String] api_key
      # @params api_token [String] api_token
      # @params contact [Contact] contact
      def initialize(api_key = nil, api_token = nil)
        @api_key = api_key
        @api_token = api_token
        connect
      end

      #
      # Checks connection
      #
      # @returns [Boolean] result
      def connect
        true
      end
    end
  end
end
