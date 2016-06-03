class ResyncEntry
  def initialize(mail_chimp_adapter:)
    @mail_chimp_adapter = mail_chimp_adapter
  end

  def call(entry)
    mail_chimp_adapter.new(api_key: entry.competition.mail_chimp_api_key)
                      .add_member_to_list(entry.competition.mail_chimp_list_id, email: entry.email)
    entry.update(sync_status: Entry::SYNCED)
    return { success: true }
  rescue MailChimpAdapter::MailChimpError => err
    Rails.logger.error("Failed to resync entry to MailChimp. #{err.message}")
    entry.update(sync_status: Entry::FAILED)
    return { success: false, error_message: err.message }
  end

  private

  attr_reader :mail_chimp_adapter
end
