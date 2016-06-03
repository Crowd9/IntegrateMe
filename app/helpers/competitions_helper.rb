module CompetitionsHelper
  def entrant_init(competition)
    ActiveModelSerializers::SerializableResource.new(
      competition,
      adapter: :json,
      root: :competition,
      serializer: CompetitionSerializer
    ).to_json
  end

  def competition_init(competition)
    ActiveModelSerializers::SerializableResource.new(
      competition,
      adapter: :json,
      root: :competition,
      serializer: CompetitionStatsSerializer
    ).to_json
  end

  def welcome_init(competitions)
    ActiveModelSerializers::SerializableResource.new(
      competitions,
      adapter: :json,
      root: :competitions,
      each_serializer: CompetitionSerializer
    ).to_json
  end
end
