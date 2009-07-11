require 'rake'

desc 'Reduce the size of PNG and JPEG files where possible'
task :crush => 'crush:all'

namespace :crush do
  task :all do
    ic = ImageCrush::Base.new
    ic.extend ImageCrush::Messages
    ic.crush(File.join(RAILS_ROOT, 'public', 'images'))
  end

  task :default => :all
end
