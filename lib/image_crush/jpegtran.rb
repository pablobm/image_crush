module ImageCrush

  module Jpegtran
    def self.available?
      @@available ||= ! %x{which jpegtran}.empty?
    end

    def self.crush(inpath, outpath)
      raise ImageCrush::CrushToolNotAvailable unless available?
      %x{jpegtran -copy none -optimize #{inpath} > #{outpath}}
    end

  end

end
