module Harbour
  module V1
    class UsageSerializer
      include Harbour::Utc

      attr_reader :usage_data

      def initialize(usage_data, year, month)
        @usage_data   = usage_data
        @year         = year
        @month        = month
      end

      def serialize(options={})
        convert_dates_to_utc(usage_data).merge(
          {
            links: [
              {
                "href": "#{Harbour::Engine.config.public_url}/api/usage/#{@year}/#{@month}",
                "rel": "self"
              },
              {
                "href": "#{Harbour::Engine.config.public_url}/api/v1/schemas/usage",
                "rel":  "schema"
              }
            ]
          }
        )
      end
    end
  end
end
