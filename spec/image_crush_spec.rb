require File.join(File.dirname(__FILE__), 'spec_helper')

require 'tmpdir'
require 'fileutils'

describe ImageCrush do

  before :each do
    remove_any_work_dirs
  end

  after :all do
    remove_any_work_dirs
  end

  describe 'exception conditions' do
    it 'should fail when the input file does not exist' do
      lambda{ImageCrush('/path/to/nowhere/fast')}.should raise_error(ImageCrush::InputFileNotFound)
    end

    it 'should fail when the crush tool is not available' do
      ImageCrush::Pngcrush.should_receive(:available?).and_return(false)
      lambda{ImageCrush(DICE_PATH)}.should raise_error(ImageCrush::CrushToolNotAvailable)
    end
  end

  describe 'individual files' do
    it 'should crush PNG files' do
      image_path = copy_file_to_tmpdir(DICE_PATH)
      should_reduce_size_of_image(image_path)
    end

    it 'should crush JPEG files' do
      image_path = copy_file_to_tmpdir(MMAN_PATH)
      should_reduce_size_of_image(image_path)
    end

    it 'should ignore other files' do
      path = copy_file_to_tmpdir(README_PATH)
      ImageCrush(path)
      File.exist?('/tmp/image_crush/README.txt').should == false
    end


    private

    def should_reduce_size_of_image(path)
      f = File.open(path)
      size_before = f.stat.size
      f.close
      ImageCrush(path)
      f = File.open(path)
      size_after = f.stat.size
      f.close
      size_after.should < size_before
    end
  end


  describe 'recursive crush' do
    before do
      create_work_dir
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

