require 'image_crush/pngcrush'

module ImageCrush

  def self.crush(path)
    raise ImageCrush::InputFileNotFound unless File.exist?(path)
    raise ImageCrush::CrushToolNotAvailable unless Pngcrush.available?

    if File.file?(path)
      crush_file(path)
    elsif File.directory?(path)
      crush_dir(path)
    else
      raise "I don't know what to do with #{path}"
    end
  end

  def self.crush_file(path)
    Pngcrush.crush(path)
  end

  def self.crush_dir(path)
    Dir.foreach(path) do |entry|
      next if %w{. ..}.include?(entry)
      crush(File.join(path, entry))
    end
  end

  class CrushToolNotAvailable < StandardError
  end

  class InputFileNotFound < StandardError
  end
end

def ImageCrush(path)
  ImageCrush.crush(path)
end
