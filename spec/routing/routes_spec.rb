require 'spec_helper'

describe :routes do
  describe 'GET "root"' do
    it { {get: '/'}.should route_to(:controller => 'top', :action => 'index') }
  end

  describe 'GET "welcome"' do
    it { {get: '/welcome'}.should route_to(:controller => 'top', :action => 'welcome') }
  end

  describe 'GET "venues"' do
    it { {get: '/venues'}.should route_to(:controller => 'top', :action => 'venues') }
  end

  describe 'GET "mentions"' do
    it { {get: '/mentions/4bd84162e914a593bdbf52fa'}.should route_to(:controller => 'mention', :action => 'mentions', :venue_id => "4bd84162e914a593bdbf52fa") }
  end

  describe 'POST "mention"' do
    it { {post: '/mention/4bd84162e914a593bdbf52fa'}.should route_to(:controller => 'mention', :action => 'create', :venue_id => "4bd84162e914a593bdbf52fa") }
  end

  describe 'DELETE "mention"' do
    it { {delete: '/mention/111111/delete'}.should route_to(:controller => 'mention', :action => 'destroy', :id => "111111") }
  end

  describe 'GET "/venue/new"' do
    it { {get: '/venue/new?ll=35.689927,139.69172'}.should route_to(:controller => 'venue', :action => 'new') }
  end

  describe 'POST "/venue/create"' do
    it { {post: '/venue/create'}.should route_to(:controller => 'venue', :action => 'create') }
  end
end
