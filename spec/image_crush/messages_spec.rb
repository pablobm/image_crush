require File.join(File.dirname(File.dirname(__FILE__)), 'spec_helper')

require 'tmpdir'
require 'fileutils'

describe ImageCrush::Messages do

  it 'prints a message to stdout after crushing a file' do
    mock_stdout = ''
    ic = ImageCrush::Base.new
    ic.extend ImageCrush::Messages
    ic.stub!(:print).and_return{|str| mock_stdout << str }
    ic.stub!(:puts).and_return{|str| mock_stdout << str << "\n" }
    path = copy_file_to_tmpdir(DICE_PATH)
    ic.crush(path)
    mock_stdout.should == "#{path}: 9K -> 8.9K (98.88%)\n"
  end

end

