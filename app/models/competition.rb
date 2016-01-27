class Competition < ActiveRecord::Base
  has_many :entries, inverse_of: :competition

  validates_presence_of :name

  # TODO: Add more search query
  def self.search(params = {})
    scope = self.all

    return scope
  end
end
