Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity,
    :fields => [:name, :email]
  provider :ldap,
    :title => "EF LDAP", 
    #:host => 'cnshhq-gc1',
    :host => '10.128.34.91',
    :port => 389,
    :method => :plain,
    :base => 'dc=ef, dc=com',
    :uid => 'sAMAccountName',
    :bind_dn => 'CN=qa testauto,OU=DL and Support Accounts,OU=CNSHHQ,OU=Offices,OU=CHINA,OU=APAC,DC=ef,DC=com',
    :password => 'efef@123'
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}