class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :email 

  validates_format_of :name, :with => /\A[A-za-z\ \-']+\z/
  validates_format_of :email, :with => /@berkeley\.edu/

  validates_uniqueness_of :email

  has_and_belongs_to_many :groups

  has_many :trips
end
