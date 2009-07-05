module ImageCrush

  module Pngcrush
    def self.available?
      ! %x{which pngcrush}.empty?
    end
    
    def self.crush(path)
      if File.file?(path)
        self.crush_file(path)
      elsif File.directory?(path)
        self.crush_dir(path)
      else
        raise "I don't know what to do with #{path}"
      end
    end
    
    def self.crush_dir(path)
      Dir.foreach(path) do |entry|
        next if %w{. ..}.include?(entry)
        crush(File.join(path, entry))
      end
    end
    
    def self.crush_file(path)
      wdir = tmpdir
      FileUtils.cp_r path, wdir
      png_path = File.join(wdir, File.basename(path))
      crushed_path = png_path + '.crushed'
      %x{pngcrush #{png_path} #{crushed_path}}
      FileUtils.cp(crushed_path, path) if File.exist?(crushed_path)
    end
    
    def self.tmpdir
      ret = File.join(Dir.tmpdir, 'pngcrush')
      FileUtils.mkdir_p(ret)
      ret
    end
  end

end
