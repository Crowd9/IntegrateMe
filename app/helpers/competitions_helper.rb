module CompetitionsHelper
  def competition_entrant_page(competition)
    "/#{competition.id}/#{competition.name.downcase.gsub(/[^a-z0-9 _\-]/i, '').gsub(/[ _-]/, '-')}"
  end

  def entrant_init(entry)
    competition = entry.competition
    {
      competition: {
        id: competition.id,
        name: competition.name,
        requires_entry_name: competition.requires_entry_name?
      }
    }.to_json
  end
end
