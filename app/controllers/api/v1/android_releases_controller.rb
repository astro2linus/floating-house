module Api
  module V1
    class AndroidReleasesController < ReleasesController

      private
      def release_params
        params.require(:android_release).permit(:name, :version, :notes, :apk_file, :icon)
      end

    end
  end
end
