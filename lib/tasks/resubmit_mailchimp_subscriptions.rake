namespace :mail_chimp do
  task :resubmit => :environment do
    count = 0
    Entry.where(:mail_chimp_subscribed => false).find_each do |entry|
      count += 1
      SubscribeUserInMailChimpJob.perform_later(entry,
        list_id: ENV['INTEGRATEMEINFO_LIST_ID'])
    end
    result = case count
    when 0
      "No unsubmitted entries were found."
    when 1
      "One unsubmitted entry has been queued for submission"
    else
      "#{count} unsubmitted entries have been queued for submission"
    end
    puts result
  end
end