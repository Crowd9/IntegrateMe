require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe '#index' do
    it 'should render the homepage' do
      get :index

      expect(response).to render_template('index')
    end
  end
end
