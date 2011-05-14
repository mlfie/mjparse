# -*- coding: utf-8 -*-
require 'twitter'

module Mjt
  class Tsumotter
    CONSUMER_KEY        = 'CCiwUEet9Vsmzy27MD6Tyg'
    CONSUMER_SECRET     = 'ZsRLLic0gOApsEVlVjATueVtxZZeEsMMlJkvxJps6Do'
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
    
    def update(agari)
      kana_list = agari.yaku_list.map do |yaku|
        yaku.name_kana
      end
      message = kana_list.join(' ') + 'は' + agari.total_point.to_s + '点です。'
      p '----- Twitter -----'
      p message
      p '----- Twitter -----'
      Twitter.update(message)
    end
  end
end