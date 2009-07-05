require 'image_crush/base'
require 'image_crush/pngcrush'
require 'image_crush/jpegtran'

module ImageCrush
end

def ImageCrush(path)
  ImageCrush.crush(path)
end
