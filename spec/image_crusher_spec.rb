require File.join(File.dirname(__FILE__), 'spec_helper')

require 'tmpdir'
require 'fileutils'

describe ImageCrusher do

  FIXTURES_ROOT = File.join(File.dirname(__FILE__), 'fixtures')
  DICE_PATH = File.join(FIXTURES_ROOT, 'dice.png')

  describe 'exception conditions' do
    it 'should fail when the input file does not exist' do
      lambda{ImageCrusher('/path/to/nowhere/fast')}.should raise_error(ImageCrusher::InputFileNotFound)
    end

    it 'should fail when the crush tool is not available' do
      ImageCrusher::Pngcrush.should_receive(:available?).and_return(false)
      lambda{ImageCrusher(DICE_PATH)}.should raise_error(ImageCrusher::CrushToolNotAvailable)
    end
  end

  describe 'shortcuts' do
    it 'should call ImageCrusher.crush(path) upon a clal to ImageCrusher(path)' do
      ImageCrusher.should_receive(:crush).with('blah')
      ImageCrusher('blah')
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
      ImageCrusher(@dice_path)
      f = File.open(@dice_path)
      size_after = f.stat.size
      f.close
      size_after.should < size_before
    end
  end
end
