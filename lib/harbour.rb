require "harbour/engine"
require "apipie-rails"
require "maruku"

require_relative "../app/helpers/harbour/curl_helper"

module Harbour
  Mime::Type.register 'application/vnd.datacentred.api+json', :dc_json

  Apipie.configure do |config|
    config.app_name                = "DataCentred RESTful API"
    config.copyright               = "DataCentred Ltd #{Time.now.year}"
    config.api_base_url            = ""
    config.doc_base_url            = "/api/docs"
    config.default_version         = Harbour::Engine.config.latest_api_version.downcase.to_s
    config.api_controllers_matcher = "#{Harbour::Engine.root}/app/controllers/harbour/**/*.rb"
    config.markup                  = Apipie::Markup::Markdown.new
    config.validate                = false
    config.app_info                = <<-EOS
  # Authentication

  Use the `Authorization` header to supply your access key and secret key:

  <pre class="prettyprint">
  curl '#{Harbour::Engine.config.public_url}' \\
  -H 'Authorization: Token ACCESS_KEY:SECRET_KEY'</pre>

  # Versions & Formats

  Target specific versions and formats by using the `Accept` header:

  <pre class="prettyprint">
  curl '#{Harbour::Engine.config.public_url}' \\
  -H 'Accept: application/vnd.datacentred.api+json; version=1'</pre>
    EOS
  end
end
