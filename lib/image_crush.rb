module ImageCrush
  LIB_ROOT = File.dirname(__FILE__)
end

base_dir = File.join(ImageCrush::LIB_ROOT, 'image_crush')
require File.join(base_dir, 'base')
require File.join(base_dir, 'pngcrush')
require File.join(base_dir, 'jpegtran')
require File.join(base_dir, 'messages')
load File.join(File.dirname(ImageCrush::LIB_ROOT), 'tasks', 'image_crush.rake')

def ImageCrush(path)
  ImageCrush::Base.new.crush(path)
end
