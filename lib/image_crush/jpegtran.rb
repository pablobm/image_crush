module ImageCrush

  module Jpegtran
    def self.available?
      ! %x{which jpegtran}.empty?
    end

    def self.crush(inpath, outpath)
      %x{jpegtran -copy none -optimize #{inpath} > #{outpath}}
    end

  end

end
