require 'spec_helper'


describe App::Controller do

  include Rack::Test::Methods

  def app
    App::Controller
  end

  context 'API endpoints' do

    context 'Non existant endpoint' do
      it 'should not load pages that do not exist' do
        visit '/vk/fail'
        expect(page).to have_content 'Not Found'
        get '/vk/fail'
        last_response.status.should == 404
      end
    end



  end


end