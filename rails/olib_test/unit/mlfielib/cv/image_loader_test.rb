require 'test/unit'
require 'test_helper'
require 'cv_test_helper'
require 'opencv'
require 'mlfielib/cv/image_loader'

class ImageLoaderTest < Test::Unit::TestCase
  include CvTestHelper
  include OpenCV
  include Mlfielib::CV

  TEST_IMG_PATH="olib_test/unit/mlfielib/cv/test_img/"

  def setup
    @loader = ImageLoader.new
  end

  def test_load
    mat = @loader.load("olib_test/unit/mlfielib/cv/test_img/m1.t.jpg",
    :rotate => 90)

    win = GUI::Window.new "debug test_load"
    win.show mat
    GUI::wait_key
  end

end
