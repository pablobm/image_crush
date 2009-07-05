module ImageCrush

  module Pngcrush
    def self.available?
      ! %x{which pngcrush}.empty?
    end

    def self.crush(inpath, outpath)
      %x{pngcrush -rem alla -brute -reduce #{inpath} #{outpath}}
    end

  end

end
