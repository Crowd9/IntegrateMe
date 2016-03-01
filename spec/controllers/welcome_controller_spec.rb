require 'rails_helper'

describe WelcomeController do

  context 'index' do

    let(:competition) { double(Competition) }
    let(:all_scope)   { double('all') }

    it 'shows a list of competitions' do
      expect(all_scope).to receive(:order).with('created_at desc').and_return([competition])
      expect(Competition).to receive(:all).and_return(all_scope)

      get :index
      expect(response).to be_success
      expect(response).to render_template('index')
    end

    it 'handles an empty list of competitions' do
      expect(all_scope).to receive(:order).with('created_at desc').and_return([])
      expect(Competition).to receive(:all).and_return(all_scope)

      get :index
      expect(response).to be_success
      expect(response).to render_template('index')
    end

  end

end