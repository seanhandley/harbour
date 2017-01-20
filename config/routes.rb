Rails.configuration.api_versions.each do |v|
  require_relative "./routes/api_routes/#{v.to_s.downcase}"
end

Harbour::Engine.routes.draw do

  root :to => redirect('/api/docs')
  
  Harbour::Engine.config.api_versions.each do |version|
    scope module: version.downcase, constraints: Harbour::ApiVersionConstraint.new(version: version) do
      extend "ApiRoutes::#{version}".constantize
    end
  end
end
