class CompetitionStatsSerializer < ApplicationSerializer
  attributes :id, :name
  has_many :unsynced_entries, serializer: EntrySerializer
end
