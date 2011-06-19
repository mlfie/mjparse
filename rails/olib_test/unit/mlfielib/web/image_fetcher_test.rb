require 'test/unit'
require 'test_helper'
require 'mlfielib/web/image_fetcher'

class CardChooserTest < Test::Unit::TestCase
  def setup
    @uri = "http://mjt.fedc.biz/img/9.jpg"
    @fetcher = Mlfielib::Web::ImageFetcher.new
  end

  def test_save_image
    path = @fetcher.save_image(@uri)
    f = open("/tmp/image_fetcher_test.jpg", "wb")
    open(path, "rb") do |file|
      f.write(file.read)
    end
  end
end
