Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
    methods: [ :post, :put, :patch, :delete, :options, :head]
  end
end