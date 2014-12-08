class ManifestsController < ApplicationController
  skip_before_filter :validate_user
  after_filter :set_access_control_headers
	force_ssl

  def show
  	@release = Release.find params[:id]

    plist_data = {
      items: [{
        assets: [{
          kind: 'software-package',
          url: "#{root_url}#{@release.ipa_file.url}"
        }],
        metadata: {
          'bundle-identifier' => @release.identifier,
          kind: 'software',
          subtitle: @release.name,
          title: @release.name
        }
      }]
    }

    plist = CFPropertyList::List.new
    plist.value = CFPropertyList.guess(plist_data)
    xml_parser = CFPropertyList::NokogiriXMLParser.new
    render text: xml_parser.to_str(root: plist.value)
  end

  def ssl_test
    render text: 'ok' 
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
  end
end
