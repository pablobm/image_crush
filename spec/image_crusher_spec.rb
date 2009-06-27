require 'lib/image_crusher'

describe ImageCrusher do

  FIXTURES_ROOT = File.join(File.dirname(__FILE__), 'fixtures')
  DICE_PATH = File.join(FIXTURES_ROOT, 'dice.png')

  describe 'exception conditions' do
    it 'should fail when the input file does not exist' do
      lambda{ImageCrusher('/path/to/nowhere/fast')}.should raise_error(ImageCrusher::InputFileNotFound)
    end

    it 'should fail when the crush tool is not available' do
      lambda{ImageCrusher(DICE_PATH)}.should raise_error(ImageCrusher::CrushToolNotAvailable)
    end
  end

end
