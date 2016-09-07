Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity,
    :fields => [:name, :email]
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}