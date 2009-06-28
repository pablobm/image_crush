module ImageCrush

  module Pngcrush
    def self.available?
      ! %x{which pngcrush}.empty?
    end
    
    def self.crush(path)
      wdir = tmpdir
      FileUtils.cp path, wdir
      png_path = File.join(wdir, File.basename(path))
      crushed_path = png_path + '.crushed'
      %x{pngcrush #{png_path} #{crushed_path}}
      FileUtils.cp(crushed_path, path)
    end
    
    def self.tmpdir
      ret = File.join(Dir.tmpdir, 'pngcrush')
      FileUtils.mkdir_p(ret)
      ret
    end
  end

end
