module Harbour
  class ApplicationController < ActionController::API
    respond_to :json

    resource_description do
      formats [:json]
    end

    protected

    before_action :restrict_content_type, :set_api_version_header

    def restrict_content_type
      if['POST', 'PUT'].include?(request.method)
        unless request.content_type == Mime[:json]
          render json: {error:  'Content-Type must be application/json'}, status: 406
        end
      end
    end

    def respond_with(content, args={})
      params = {json: content, content_type: Mime::Type.lookup_by_extension(:dc_json).to_s}
      render params.merge(args)
    end

    rescue_from ActiveRecord::RecordInvalid,  with: :render_unprocessable_entity_response

    def render_unprocessable_entity_response(exception)
      render json: {
        errors: ValidationErrorsSerializer.new(exception.record).serialize
      }, status: :unprocessable_entity
    end

    rescue_from ActionController::RoutingError, with: :render_not_found

    def render_not_found
      head :not_found
    end

    def set_api_version_header
      version = request.headers.fetch(:accept)&.scan(/version=(\d+)/)&.first&.first
      if version
        unless Harbour::Engine.config.api_versions.include?("V#{version}".to_sym)
          render json: {
            error: "Unknown API version #{version}.",
            links: [
              {href: Harbour::Engine.config.public_url, rel: 'help'}
            ] 
          }, status: 406
        end
      else
        version = Harbour::Engine.config.latest_api_version.to_s.scan(/V(\d+)/).first.first
      end
      response.headers['X-API-Version'] = version
    end

  end
end
