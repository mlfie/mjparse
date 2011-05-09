class Agari < ActiveRecord::Base
  has_and_belongs_to_many :yaku_list, :class_name => 'Yaku'
end
