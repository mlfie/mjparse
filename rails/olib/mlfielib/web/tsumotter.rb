# -*- coding: utf-8 -*-
require 'date'
require 'twitter'

module Mlfielib
  module Web
    class Tsumotter
      CONSUMER_KEY        = 'CCiwUEet9Vsmzy27MD6Tyg'
      CONSUMER_SECRET     = 'ZsRLLic0gOApsEVlVjATueVtxZZeEsMMlJkvxJps6Do'
#      OAUTH_TOKEN         = '57991737-AShdyddCJlG4zfzXxGjpMC4NzK4n78vPkzt3XpPDF'
#      OAUTH_TOKEN_SECRET  = '9uoOQKydTcgFjBs5Ehaa2sJpcqh23NSEQxsSQieg'
      OAUTH_TOKEN         = '294404275-lRuBF14zQmXPl7crkkYs5BtSDqKavfNe2cROeGT4'
      OAUTH_TOKEN_SECRET  = 'dTxFc4SYp2x8ouyLtTAVlroiskmK0S6cC0gQ2C2nA'
    
      def initialize
        Twitter.configure do |config|
          config.consumer_key = CONSUMER_KEY
          config.consumer_secret = CONSUMER_SECRET
          config.oauth_token = OAUTH_TOKEN
          config.oauth_token_secret = OAUTH_TOKEN_SECRET
        end
      end
    
      def update(message)
        Twitter.update(message)
        STDERR.puts Time.new.to_s + "：つぶやき「" + message + "」"
      end
    end
  end
end