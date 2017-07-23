require "rails_helper"

describe Entry do
  before do
    @competition = Competition.create(name: "Email only comp", requires_entry_name: false)
  end

  # it "should require a name" do
  #   expect { Entry.create!(name: nil) }.to    raise_error(ActiveRecord::RecordInvalid)
  # end
  #
  # describe 'email' do
  #   it 'creates entry with name and email' do
  #     expect { Entry.create!(name: 'test entry', email: 'testing@testing.com', competition: @competition) }.not_to raise_error(ActiveRecord::RecordInvalid)
  #   end
  # end
  #
  # it "should require a email" do
  #   expect { Entry.create!(name: 'test entry', email: nil) }.to  raise_error(ActiveRecord::RecordInvalid)
  # end
end
