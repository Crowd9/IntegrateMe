module CompetitionsHelper
  def competition_entrant_page(competition)
    "/#{competition.id}/#{competition.name.downcase.gsub(/[^a-z0-9 _\-]/i, '').gsub(/[ _-]/, '-')}"
  end

  def entrant_init(entry, campaign)
    hash ={
        competition: {
            id: entry.competition.id,
            name: entry.competition.name,
            requires_entry_name: entry.competition.requires_entry_name?,
            entry_name: entry.name,
            entry_email: entry.email
        }
    }
    hash[:campaign_id] = campaign.id if campaign
    hash[:entry_id] = entry.id
    hash.to_json
  end
end
