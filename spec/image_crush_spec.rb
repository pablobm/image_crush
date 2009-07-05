require File.join(File.dirname(__FILE__), 'spec_helper')

require 'tmpdir'
require 'fileutils'

describe ImageCrush do

  FIXTURES_ROOT = File.join(File.dirname(__FILE__), 'fixtures')
  DICE_PATH = File.join(FIXTURES_ROOT, 'dice.png')
  CCBY_PATH = File.join(FIXTURES_ROOT, 'subdir', 'cc-by-icon.png')
  MMAN_PATH = File.join(FIXTURES_ROOT, 'happy-mailman.jpg')
    
  describe 'exception conditions' do
    it 'should fail when the input file does not exist' do
      lambda{ImageCrush('/path/to/nowhere/fast')}.should raise_error(ImageCrush::InputFileNotFound)
    end

    it 'should fail when the crush tool is not available' do
      ImageCrush::Pngcrush.should_receive(:available?).and_return(false)
      lambda{ImageCrush(DICE_PATH)}.should raise_error(ImageCrush::CrushToolNotAvailable)
    end
  end

  describe 'shortcuts' do
    it 'should call ImageCrush.crush(path) upon a clal to ImageCrush(path)' do
      ImageCrush.should_receive(:crush).with('blah')
      ImageCrush('blah')
    end
  end

  describe 'crushing dice.png' do
    before do
      tmpdir = File.join(Dir.tmpdir, 'image_crush.spec')
      FileUtils.mkdir_p(tmpdir)
      FileUtils.cp DICE_PATH, tmpdir
      @dice_path = File.join(tmpdir, 'dice.png')
    end

    it 'should reduce the file size' do
      f = File.open(@dice_path)
      size_before = f.stat.size
      f.close
      ImageCrush(@dice_path)
      f = File.open(@dice_path)
      size_after = f.stat.size
      f.close
      size_after.should < size_before
    end
  end

  describe 'crushing happy-mailman.jpg' do
    before do
      tmpdir = File.join(Dir.tmpdir, 'image_crush.spec')
      FileUtils.mkdir_p(tmpdir)
      FileUtils.cp MMAN_PATH, tmpdir
      @mman_path = File.join(tmpdir, 'happy-mailman.jpg')
    end

    it 'should reduce the file size' do
      f = File.open(@mman_path)
      size_before = f.stat.size
      f.close
      ImageCrush(@mman_path)
      f = File.open(@mman_path)
      size_after = f.stat.size
      f.close
      size_after.should < size_before
    end
  end

  describe 'recursive crush' do
    before do
      @work_dir = File.join(Dir.tmpdir, 'image_crush.spec')
      FileUtils.rm_rf(@work_dir)
      FileUtils.mkdir_p(@work_dir)
      FileUtils.cp_r Dir.glob(File.join(FIXTURES_ROOT, '**')), @work_dir
      @dice_path = File.join(@work_dir, File.basename(DICE_PATH))
      @ccby_path = File.join(@work_dir, 'subdir', File.basename(CCBY_PATH))
    end

    it 'should recursively crush all images in a directory' do
      f1 = File.open(@dice_path)
      size1_before = f1.stat.size
      f1.close
      f2 = File.open(@ccby_path)
      size2_before = f2.stat.size
      f2.close
      
      ImageCrush(@work_dir)
      
      f1 = File.open(@dice_path)
      size1_after = f1.stat.size
      f1.close
      f2 = File.open(@ccby_path)
      size2_after = f2.stat.size
      f2.close
      
      size1_after.should < size1_before
      size2_after.should < size2_before
    end
  end

end
