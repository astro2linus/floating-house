module FH
  class API < Grape::API
    prefix 'api'
    version 'v1', using: :header, vendor: 'FH'
    format :json
    

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

    add_swagger_documentation api_version: 'v1'
  end
end