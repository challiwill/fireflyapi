class Group < ActiveRecord::Base
  validates_presence_of :name

  validates_format_of :name, :with => /\A[A-za-z\ \-']+\z/

  validates_uniqueness_of :name
end
