class ManifestsController < ApplicationController
  skip_before_filter :validate_user
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

end
