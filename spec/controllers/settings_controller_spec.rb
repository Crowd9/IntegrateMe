require 'rails_helper'

describe Api::V1::SettingsController, :type => :controller do
  describe "GET index" do
    let!(:setting) {FactoryGirl.create(:setting)}

    it "should return all settings in json" do
      get :index

      expect(response.status).to eql(200)
      expect(json["results"]).to be_present
      expect(json["results"].length).to eql(Setting.count)
      expect(json["results"][0]["id"]).to eql(setting.id)
    end

    it "should allow search setting" do
      search_params = {:code => "mailchimp"}
      expect(Setting).to receive(:search).with(search_params)
      get :index, :search => search_params
      expect(response.status).to eql(200)
    end
  end

  describe "POST create" do
    it "should create setting" do
      attrs = FactoryGirl.attributes_for(:setting)
      expect {
        post :create, :setting => attrs
      }.to change{Setting.count}.by(1)

      expect(response.status).to eql(200)
      expect(json["results"]).to be_present
      expect(json["results"]["code"]).to eql(attrs[:code].to_s)
    end

    it "should update existing code" do
      attrs = FactoryGirl.attributes_for(:setting)
      setting = Setting.create!(attrs)
      attrs[:raw][:a] = 2

      expect {
        post :create, :setting => attrs.merge(:a => 2)
      }.to change{Setting.count}.by(0)

      expect(setting.reload.raw["a"]).to eql("2")
    end
  end
end
