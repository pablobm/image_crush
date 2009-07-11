$: << File.join(File.dirname(File.dirname(__FILE__)), 'lib')

require 'image_crush'
require 'image_crush/pngcrush'

FIXTURES_ROOT = File.join(File.dirname(__FILE__), 'fixtures')
DICE_PATH = File.join(FIXTURES_ROOT, 'dice.png')
CCBY_PATH = File.join(FIXTURES_ROOT, 'subdir', 'cc-by-icon.png')
MMAN_PATH = File.join(FIXTURES_ROOT, 'happy-mailman.jpg')
README_PATH = File.join(FIXTURES_ROOT, 'README.txt')

def copy_file_to_tmpdir(path)
  create_work_dir
  FileUtils.cp path, @work_dir
  File.join(@work_dir, path.gsub(FIXTURES_ROOT, ''))
end

def remove_any_work_dirs
  Dir.glob(File.join(Dir.tmpdir, 'image_crush.spec.*')).each{|path| FileUtils.rm_rf(path)}
end

def create_work_dir
  @work_dir = File.join(Dir.tmpdir, 'image_crush.spec.' + $$.to_s)
  FileUtils.mkdir_p(@work_dir)
end

