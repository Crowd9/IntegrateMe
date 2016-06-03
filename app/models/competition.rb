class Competition < ActiveRecord::Base
  EMAIL_REGEX = /\A[A-Z0-9._%a-z\-+]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,12}\z/

  has_many :entries, inverse_of: :competition
  has_many :unsynced_entries,
           -> { where('sync_status != ?', Entry::SYNCED) },
           class_name: :Entry,
           foreign_key: :competition_id
  validates_presence_of :name
  validates_presence_of :runner_email
  validates_format_of :runner_email, with: EMAIL_REGEX, allow_blank: true, allow_nil: true
end
