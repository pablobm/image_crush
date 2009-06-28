require 'image_crusher/pngcrush'

module ImageCrusher

  def self.crush(path)
    raise ImageCrusher::InputFileNotFound unless File.exist?(path)
    raise ImageCrusher::CrushToolNotAvailable unless Pngcrush.available?

    Pngcrush.crush(path)
  end

  class CrushToolNotAvailable < StandardError
  end

  class InputFileNotFound < StandardError
  end
end

def ImageCrusher(path)
  ImageCrusher.crush(path)
end
