module FH
  class API < Grape::API
    prefix 'api'
    version 'v1', using: :header, vendor: 'FH'
    format :json
    
    before do
      header "Access-Control-Allow-Origin", "*"
    end

    helpers do
      def manifest_ipa_url(release)
        plist_url = manifest_url(release).sub('http', 'https')
        "itms-services://?action=download-manifest&url=#{plist_url}"
      end
    end

    desc 'Returns the version of api'
    get 'version' do
      { version: 'v1'}
    end

    desc 'Return users'
    resource :users do 
      get '/' do
        User.all
      end

      get ':id' do
        User.find params[:id]
      end
    end

    desc 'Return products'
    get 'products' do
      Product.all
    end

    desc 'Return releases of a product'
    get 'products/:id/releases' do
      releases = Product.find(params[:id]).releases
      releases.map do |r|
        r['plist_url'] = manifest_ipa_url(r)
      end
      releases
    end

    add_swagger_documentation api_version: 'v1'
  end
end