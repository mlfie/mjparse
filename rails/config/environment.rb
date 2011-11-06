# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MjTsumotter::Application.initialize!

# ppの出力をlog/out.logに出すカスタマイズ
require 'pp'
module Kernel
  private
  def pp(*objs)
    logger = Logger.new File.join(RAILS_ROOT, 'log', 'out.log')
    objs.each { |obj| logger.debug PP.pp(obj, '') }
    nil
  end
end
