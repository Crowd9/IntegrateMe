require 'rails_helper'

describe 'welcome' do
  let(:destination) { {'controller' => 'welcome'} }

  it 'routes to #index from root' do
    expect(:get => '/').to route_to(destination.merge(action: 'index'))
  end

  it 'does not route to #new' do
    expect(:get => '/welcome/new').not_to route_to(destination.merge(action: 'new'))
  end

  it 'does not route to #create' do
    expect(:post => '/welcome').not_to route_to(destination.merge(action: 'create'))
  end

  it 'does not route to #show' do
    expect(:get => '/welcome/1').not_to route_to(destination.merge(action: 'show', id: '1'))
  end

  it 'does not route to #edit' do
    expect(:get => '/welcome/1/edit').not_to route_to(destination.merge(action: 'edit', id: '1'))
  end

  it 'does not route to #update (put)' do
    expect(:put => '/welcome/1').not_to route_to(destination.merge(action: 'update', id: '1'))
  end

  it 'does not route to #update (patch)' do
    expect(:patch => '/welcome/1').not_to route_to(destination.merge(action: 'update', id: '1'))
  end

  it 'does not route to #destroy' do
    expect(:delete => '/welcome/1').not_to route_to(destination.merge(action: 'destroy', id: '1'))
  end
end
