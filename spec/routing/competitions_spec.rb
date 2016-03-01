require 'rails_helper'

describe 'competitions' do
  let(:destination) { {'controller' => 'competitions'} }

  it 'does not route to #index' do
    expect(:get => 'competitions').not_to route_to(destination.merge(action: 'index'))
  end

  it 'does not route to #new' do
    expect(:get => '/competitions/new').not_to route_to(destination.merge(action: 'new'))
  end

  it 'does not route to #create' do
    expect(:post => '/competitions').not_to route_to(destination.merge(action: 'create'))
  end

  it 'routes to #entrant_page' do
    expect(:get => '1/my_competition').to route_to(destination.merge(action: 'entrant_page',
      permalink: 'my_competition', competition_id: '1'))
  end

  it 'does not route to #edit' do
    expect(:get => '1/edit').not_to route_to(destination.merge(action: 'edit', id: '1'))
  end

  it 'does not route to #update (put)' do
    expect(:put => '1').not_to route_to(destination.merge(action: 'update', id: '1'))
  end

  it 'does not route to #update (patch)' do
    expect(:patch => '1').not_to route_to(destination.merge(action: 'update', id: '1'))
  end

  it 'does not route to #destroy' do
    expect(:delete => '1').not_to route_to(destination.merge(action: 'destroy', id: '1'))
  end
end
