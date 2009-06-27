class ImageCrusher

  def self.crush(path)
    raise ImageCrusher::InputFileNotFound unless File.exist?(path)
    raise ImageCrusher::CrushToolNotAvailable    
  end

  class CrushToolNotAvailable < StandardError
  end

  class InputFileNotFound < StandardError
  end

end

def ImageCrusher(path)
  ImageCrusher.crush(path)
end
