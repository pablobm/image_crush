require 'image_crush/pngcrush'

module ImageCrush

  def self.crush(path)
    raise ImageCrush::InputFileNotFound unless File.exist?(path)
    raise ImageCrush::CrushToolNotAvailable unless Pngcrush.available?

    Pngcrush.crush(path)
  end

  class CrushToolNotAvailable < StandardError
  end

  class InputFileNotFound < StandardError
  end
end

def ImageCrush(path)
  ImageCrush.crush(path)
end
