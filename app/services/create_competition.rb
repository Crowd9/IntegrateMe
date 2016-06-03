class CreateCompetition
  def initialize(mail_chimp_adapter:)
    @mail_chimp_adapter = mail_chimp_adapter
  end

  def call(competition_params)
    competition = Competition.new(competition_params)
    if competition.valid? && validate_mail_chimp_list_id(competition)
      competition.save!
      { success: true, competition: competition }
    else
      { success: false, errors: competition.errors }
    end
  end

  private

  attr_reader :mail_chimp_adapter

  def validate_mail_chimp_list_id(competition)
    if competition.mail_chimp_list_id.blank?
      competition.errors.add(:mail_chimp_list_id, 'can\'t be blank')
      false
    else
      adapter = mail_chimp_adapter.new(api_key: competition.mail_chimp_api_key)
      adapter.find_list(competition.mail_chimp_list_id)
      true
    end
  rescue MailChimpAdapter::MailChimpError => err
    competition.errors.add(:mail_chimp_list_id, err.message)
    false
  end
end
