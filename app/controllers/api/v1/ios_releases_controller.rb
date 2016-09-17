module Api
  module V1
    class IosReleasesController < ReleasesController

      private
      def release_params
        params.require(:ios_release).permit(:name, :version, :notes, :ipa_file, :icon, :plist_file)
      end

    end
  end
end
