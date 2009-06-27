class ImageCrusher

    class CrushToolNotAvailable < StandardError
    end

end

def ImageCrusher(path)
  File.open(path)
  raise ImageCrusher::CrushToolNotAvailable
end
