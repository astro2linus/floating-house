module Api
  module V1
    class AndroidReleasesController < Api::V1::ReleasesController

      def download
        @release = Release.find params[:id]
        content = @release.apk_file.read
        send_data content, type: @release.apk_file.content_type, :filename => @release.apk_file
        expires_in 0, public: true
      end

      private
      def release_params
        params.require(:android_release).permit(:name, :version, :notes, :apk_file, :icon)
      end

    end
  end
end
