class Competition < ActiveRecord::Base
  belongs_to :user
  has_many :entries, inverse_of: :competition

  validates_presence_of :name
end