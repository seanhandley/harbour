require_dependency "harbour/application_controller"

module Harbour
  class AuthorizedController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :api_credential, :set_authorization

    def api_credential
      @api_credential ||= authenticate_with_http_token do |token, _|
        access, secret = token.split(':')
        credential = ApiCredential.find_by_access_key(access)
        credential&.authenticate_and_authorize(secret) ? credential : nil
      end
      @api_credential || render_unauthorized
    end

    def current_user
      api_credential&.user
    end

    def current_organization
      api_credential&.organization
    end

    def set_authorization
      Authorization.current_user         = current_user
      Authorization.current_organization = current_organization
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="DataCentred"'
      render_error(
        :unauthorized,
        [
          {
            detail: "Token authentication failed. Invalid credentials or API access is not authorized."
          }
        ]
      )
    end
  end
end
