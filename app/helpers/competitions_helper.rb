module CompetitionsHelper
  def competition_entrant_page(competition)
    "/#{competition.id}/#{competition.name.downcase.gsub(/[^a-z0-9 _\-]/i, '').gsub(/[ _-]/, '-')}"
  end

  def entrant_init(entry)
    {
        competition: { id: entry.competition.id, name: entry.competition.name, requires_entry_name: entry.competition.requires_entry_name? }
    }.to_json
  end

  def competition_init(competition)
    {
      competition: {
        id: competition.id,
        name: competition.name,
        requires_entry_name: competition.requires_entry_name?
      },
      unsynced_entries: competition.unsynced_entries.map do |entry|
        { id: entry.id, email: entry.email, name: entry.name, sync_status: entry.sync_status }
      end
    }.to_json
  end
end
