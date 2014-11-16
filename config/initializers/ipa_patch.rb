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

		def uncrush_png
			if icon
				icon_path = Rails.root.join('tmp', 'extracted_icon.png')
				File.open(icon_path, 'wb') { |file| file.write(icon) }
				cmd = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/pngcrush -revert-iphone-optimizations "
				cmd << "#{icon_path} #{icon_path.sub('extracted_icon.png', 'uncrushed_icon.png')}"
				`#{cmd}`
			end
		end
	end
end
