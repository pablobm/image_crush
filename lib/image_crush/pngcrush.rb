module ImageCrush

  module Pngcrush
    def self.available?
      ! %x{which pngcrush}.empty?
    end

    def self.crush(inpath, outpath)
      %x{pngcrush #{inpath} #{outpath}}
    end

  end

end
