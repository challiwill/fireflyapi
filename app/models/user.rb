class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :email 

  validates_format_of :email, :with => /@berkeley\.edu/

  validates_uniqueness_of :email

  has_and_belongs_to_many :groups

  has_many :trips
end
