class Competition < ActiveRecord::Base
  has_many :entries, inverse_of: :competition
  has_many :unsynced_entries,
           -> { where('sync_status != ?', Entry::SYNCED) },
           class_name: :Entry,
           foreign_key: :competition_id
  validates_presence_of :name
end
