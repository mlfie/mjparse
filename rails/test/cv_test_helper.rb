module CvTestHelper
  def self.included(base)
    @@mode = nil
  end

  def debug?
    @@mode == :debug
  end

  def debug
    yield if debug?
  end

end
