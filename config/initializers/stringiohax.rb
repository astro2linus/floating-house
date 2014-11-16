class IconStringIO < StringIO
  attr_accessor :original_filename

  def initialize(*args)
    super(*args[1..-1])
    @original_filename = args[0]
  end

  def content_type
    "image/png"
  end
end