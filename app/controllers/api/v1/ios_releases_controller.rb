module Api
  module V1
    class IosReleasesController < ReleasesController

      def download
        @release = Release.find params[:id]
        content = @release.ipa_file.read
        send_data content, type: @release.ipa_file.content_type, :filename => @release.ipa_file
        expires_in 0, public: true
      end

      private
      def release_params
        params.require(:ios_release).permit(:name, :version, :notes, :ipa_file, :icon, :plist_file)
      end

    end
  end
end
