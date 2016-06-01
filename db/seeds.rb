[
  {
    name: "Name+Email comp",
    requires_entry_name: true,
    mail_chimp_list_id: '3b79f0be47',
    runner_email: 'luke@example.com'
  },
  {
    name: "Email only comp",
    requires_entry_name: false,
    mail_chimp_list_id: 'ed491a4805',
    runner_email: 'darth@example.com'
  }
].each do |params|
  Competition.where(mail_chimp_list_id: params[:mail_chimp_list_id]).first_or_create!(params)
end
