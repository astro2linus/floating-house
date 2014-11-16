module IPA
	class IPAFile
		def icon
			begin
				path = info &&
					info['CFBundleIcons'] &&
					info['CFBundleIcons']['CFBundlePrimaryIcon'] &&
					(info['CFBundleIcons']['CFBundlePrimaryIcon']['CFBundleIconFile'] ||
					 info['CFBundleIcons']['CFBundlePrimaryIcon']['CFBundleIconFiles'].last)
				path ||= 'Icon.png'
				payload_file(path)
			rescue Errno::ENOENT
				nil
			end
		end
	end
end
