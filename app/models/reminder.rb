class Reminder < ActiveRecord::Base
  validates_presence_of :name, :description, :scheduled
  validates_length_of :name, :minimum => 5
  #has_one :user
  belongs_to :user
end
