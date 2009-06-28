require File.join(File.dirname(__FILE__), 'spec_helper')

require 'tmpdir'
require 'fileutils'

describe ImageCrush do

  FIXTURES_ROOT = File.join(File.dirname(__FILE__), 'fixtures')
  DICE_PATH = File.join(FIXTURES_ROOT, 'dice.png')
  
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
      tmpdir = File.join(Dir.tmpdir, 'image_crusher')
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
end
