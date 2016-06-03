class CompetitionSerializer < ApplicationSerializer
  include Rails.application.routes.url_helpers
  include CustomUrlHelpers

  attributes :id,
             :name,
             :requires_entry_name,
             :stats_path,
             :enter_path

  def stats_path
    competition_path(object)
  end

  def enter_path
    competition_entrant_path(object)
  end
end
