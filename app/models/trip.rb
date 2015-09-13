class Trip < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :start_latitude
  validates_presence_of :start_longitude
  validates_presence_of :end_latitude
  validates_presence_of :end_longitude
  validates_presence_of :end_time
  validates_presence_of :group_ids

  belongs_to :users

  has_and_belongs_to_many :groups
end
