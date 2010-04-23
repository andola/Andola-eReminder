class User < ActiveRecord::Base
  validates_presence_of :user_name 
  validates_presence_of :password, :on => :create 
  validates_length_of :password, :within => 5..10
  has_many :reminders
end
