module ImageCrush

  class Base

    def crush(path)
      raise ImageCrush::InputFileNotFound unless File.exist?(path)

      if File.file?(path)
        crush_file(path)
      elsif File.directory?(path)
        crush_dir(path)
      else
        raise "I don't know what to do with #{path}"
      end
    end

    def crush_file(path)
      processor = select_processor(path) or return nil
      source_path = copy_to_tempdir(path)
      crushed_path = source_path + '.crushed'
      processor.crush(source_path, crushed_path)
      FileUtils.cp(crushed_path, path) if File.exist?(crushed_path)
    end

    def crush_dir(path)
      Dir.foreach(path) do |entry|
        next if %w{. ..}.include?(entry)
        crush(File.join(path, entry))
      end
    end

    def select_processor(path)
      case path
      when /\.png$/i
        Pngcrush
      when /\.jpe?g$/i
        Jpegtran
      end
    end

    def copy_to_tempdir(path)
      wdir = tmpdir
      FileUtils.cp_r path, wdir
      File.join(wdir, File.basename(path))
    end

    def tmpdir
      ret = File.join(Dir.tmpdir, 'image_crush')
      FileUtils.mkdir_p(ret)
      ret
    end

  end # Base

  class CrushToolNotAvailable < StandardError
  end

  class InputFileNotFound < StandardError
  end

end
