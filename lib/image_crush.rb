module ImageCrush
  LIB_ROOT = File.dirname(__FILE__)
end

base_dir = File.join(ImageCrush::LIB_ROOT, 'image_crush')
require File.join(base_dir, 'base')
require File.join(base_dir, 'pngcrush')
require File.join(base_dir, 'jpegtran')

def ImageCrush(path)
  ImageCrush.crush(path)
end
