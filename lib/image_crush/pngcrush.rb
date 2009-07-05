module ImageCrush

  module Pngcrush
    def self.available?
      @@available ||= ! %x{which pngcrush}.empty?
    end

    def self.crush(inpath, outpath)
      raise ImageCrush::CrushToolNotAvailable unless available?
      %x{pngcrush -rem alla -brute -reduce #{inpath} #{outpath}}
    end

  end

end
