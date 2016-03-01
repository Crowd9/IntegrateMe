require "rails_helper"

describe Entry do

  let(:competition) { mock_model(Competition) }

  let(:name)          { 'Jane Doe' }
  let(:valid_email)   { 'jdoe@example.org'}
  let(:invalid_email) { 'jdoe' }

  context 'validations' do

    it 'is valid with name and valid email' do
      expect(competition).to receive(:requires_entry_name?).and_return(true)
      entry = Entry.new(competition: competition, name: name, email: valid_email)
      expect(entry.valid?).to be true
    end

    it 'is valid with blank name and valid email, if competition does not require entry name' do
      expect(competition).to receive(:requires_entry_name?).and_return(false)
      entry = Entry.new(competition: competition, name: nil, email: valid_email)
      expect(entry.valid?).to be true
    end

    it 'is invalid with blank name and valid email, if competition does require entry name' do
      expect(competition).to receive(:requires_entry_name?).and_return(true)
      entry = Entry.new(competition: competition, name: nil, email: valid_email)
      expect(entry.valid?).to be false
    end

    it 'is invalid with name and invalid email' do
      expect(competition).to receive(:requires_entry_name?).and_return(true)

      entry = Entry.new(competition: competition, name: name, email: invalid_email)
      expect(entry.valid?).to be false
    end

    it 'is invalid with blank name and invalid email' do
      expect(competition).to receive(:requires_entry_name?).and_return(false)

      entry = Entry.new(competition: competition, name: nil, email: invalid_email)
      expect(entry.valid?).to be false
    end

    it 'is invalid with name and blank email' do
      expect(competition).to receive(:requires_entry_name?).and_return(true)

      entry = Entry.new(competition: competition, name: name, email: nil)
      expect(entry.valid?).to be false
    end

    it 'is invalid with blank name and blank email' do
      expect(competition).to receive(:requires_entry_name?).and_return(false)

      entry = Entry.new(competition: competition, name: nil, email: nil)
      expect(entry.valid?).to be false
    end

    it 'is invalid with no competition' do
      entry = Entry.new(competition: nil, name: name, email: valid_email)
      expect(entry.valid?).to be false
    end
  end

end
