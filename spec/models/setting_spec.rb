require "rails_helper"

describe Setting do
  describe "validations" do
    it "should create setting if value and raw are valid" do
      attrs = FactoryGirl.attributes_for(:setting)
      setting = Setting.new(attrs)
      expect(setting.save).to be_truthy
      expect(setting.code).to eql(attrs[:code].to_s)
      expect(setting.raw[:a]).to eql(attrs[:raw][:a])
    end

    it "should be invalid if raw is nil" do
      setting = FactoryGirl.build(:setting, :raw => nil)
      expect(setting.save).to be_falsy
      expect(setting.errors).to be_present
      expect(setting.errors[:raw]).to be_present
    end

    it "should be invalid if raw is blank" do
      setting = FactoryGirl.build(:setting, :raw => {})
      expect(setting.save).to be_falsy
      expect(setting.errors).to be_present
      expect(setting.errors[:raw]).to be_present
    end

    it "should raise error if raw is not a hash value" do
      setting = FactoryGirl.build(:setting)
      expect{setting.raw = [1, 2, 3]}.to raise_error
    end

    it "should be invalid if code is missing" do
      setting = FactoryGirl.build(:setting, :code => nil)
      expect(setting.save).to be_falsy
      expect(setting.errors).to be_present
      expect(setting.errors[:code]).to be_present
    end

    it "should be invalid if code is already existed" do
      s = FactoryGirl.create(:setting)
      setting = FactoryGirl.build(:setting, :code => s.code.to_sym)

      expect(setting.save).to be_falsy
      expect(setting.errors).to be_present
      expect(setting.errors[:code]).to be_present
    end
  end

  describe ".search" do
    let!(:setting) { FactoryGirl.create(:competition) }

    it "should return all settings" do
      expect(Setting.search({}).count).to eql(Setting.count)
    end

    it "should search by code" do
      expect(Setting.search({:code => "mailchimp_api"}).count).to eql(Setting.where(:code => Setting.codes[:mailchimp]).count)
      expect(Setting.search({:code => "invalid"}).count).to eql(Setting.where(:code => nil).count)
    end
  end

  describe "mailchimp" do
    it "should get mailchimp list id from list name if setting is mailchimp setting" do
      setting = FactoryGirl.build(:setting, :code => :mailchimp_api,
                                     :raw => {
                                       "API Key" => SecureRandom.hex(16) + "-us8",
                                       "List Name" => Faker::Name.name
                                      })

      mailchimp_api = double(:mailchimp_api)
      allow(Mailchimp::API).to receive(:new).and_return(mailchimp_api)
      mailchimp_list = double(:mailchimp_list)
      allow(mailchimp_api).to receive(:lists).and_return(mailchimp_list)
      list_id = SecureRandom.hex(4)
      allow(mailchimp_list).to receive(:list).and_return({"data" => [{"id" => list_id, "name" => setting.raw["List Name"]}]})

      expect(setting.save).to be_truthy
      expect(setting.reload.raw["List Id"]).to eql(list_id)
    end
  end
end
