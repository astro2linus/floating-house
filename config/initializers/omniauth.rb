Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :fields => [:name, :email], locate_conditions: lambda { |req| 
    { model.auth_key => req['auth_key'] ? req['auth_key'].downcase : nil}
  }
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}