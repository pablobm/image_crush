class ImageCrusher

    class CrushToolNotAvailable < StandardError
    end

    class InputFileNotFound < StandardError
    end
end

def ImageCrusher(path)
  raise ImageCrusher::InputFileNotFound unless File.exist?(path)
  raise ImageCrusher::CrushToolNotAvailable
end
