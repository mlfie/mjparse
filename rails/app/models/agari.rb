class Agari < ActiveRecord::Base
  has_and_belongs_to_many :yaku_list, :class_name => 'Yaku'
  #has_many :tehai_list, :class_name => 'AgariPai', :order => "index"
end
