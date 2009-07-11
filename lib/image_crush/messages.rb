module ImageCrush

  module Messages

    def self.extended(base)
      class << base
        def crush_file_with_messages(path)
          size_before = File.open(path){|f| f.stat.size}
          print "#{path}: #{human_size size_before}"
          crush_file_without_messages(path)
          size_after = File.open(path){|f| f.stat.size}
          ratio = sprintf('%0.2f', size_after.to_f*100/size_before)
          puts " -> #{human_size size_after} (#{ratio}%)"
        end
        alias :crush_file_without_messages :crush_file
        alias :crush_file :crush_file_with_messages
        
        
        private
        
        def human_size(bytes)
          if bytes < 1024
            bytes
          else
            sprintf("%0.1fK", bytes.to_f/1024).gsub('.0K', 'K')
          end
        end
      end
    end

  end

end
