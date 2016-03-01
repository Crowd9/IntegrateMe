require 'rails_helper'

describe 'entries' do
  let(:destination) { {'controller' => 'entries'} }

  it 'does not route to #index' do
    expect(:get => '/entries').not_to route_to(destination.merge(action: 'index'))
  end

  it 'does not route to #new' do
    expect(:get => '/entries/new').not_to route_to(destination.merge(action: 'new'))
  end

  it 'routes to #create' do
    expect(:post => '/entries').to route_to(destination.merge(action: 'create'))
  end

  it 'routes to #show' do
    expect(:get => '/entries/1').to route_to(destination.merge(action: 'show', id: '1'))
  end

  it 'does not route to #edit' do
    expect(:get => '/entries/1/edit').not_to route_to(destination.merge(action: 'edit', id: '1'))
  end

  it 'does not route to #update (put)' do
    expect(:put => '/entries/1').not_to route_to(destination.merge(action: 'update', id: '1'))
  end

  it 'does not route to #update (patch)' do
    expect(:patch => '/entries/1').not_to route_to(destination.merge(action: 'update', id: '1'))
  end

  it 'does not route to #destroy' do
    expect(:delete => '/entries/1').not_to route_to(destination.merge(action: 'destroy', id: '1'))
  end
end
