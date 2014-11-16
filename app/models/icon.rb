class Icon
  include Mongoid::Document
  include Mongoid::Timestamps

  field :icon_data

  belongs_to :release
  mount_uploader :icon_data, IconUploader

  after_save :uncrush_png

  def image_data=(data)
  	io = IconStringIO.new("eficon.png", data)
  	self.icon_data = io
  end

  def uncrush_png
  	path = self.icon_data.path.to_s
  	cmd = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/pngcrush -revert-iphone-optimizations "
  	cmd << path
  	cmd << " "
  	cmd << path.sub('eficon', 'eficon1')
  	puts "@$!" * 30
  	puts cmd
  	 `#{cmd}`
  end

end
