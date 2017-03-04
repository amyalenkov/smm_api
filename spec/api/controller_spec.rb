require 'spec_helper'


describe App::Controller do

  include Rack::Test::Methods

  def app
    App::Controller
  end

  context 'API endpoints' do

    context 'Non existant endpoint' do
      it 'should not load pages that do not exist' do
        get '/vk/fail'
        expect(last_response.status).to eq 404
        get '/vk/fail'
        expect(last_response.status).to eq 404
      end
    end

    context 'auth endpoint' do

      it 'should return 404 if user_id is not found' do
        get '/vk/auth/get_access_token?user_id=12345'
        expect(last_response.status).to eq 404
      end

      it 'should return 400 if user_id is not in request' do
        get '/vk/auth/get_access_token?user_id=12345'
        expect(last_response.status).to eq 404
      end

      it 'should return auth url' do
        url = LoadData.load_auth_url
        get '/vk/auth/get_url'
        expect(last_response.status).to eq 200
        actual_url = JSON.parse(last_response.body)['url']
        expect(actual_url).to eq url
      end

      it 'should return access token' do
        user_id = 123
        access_token = '456'
        LoadData.load_access_token user_id, access_token
        get '/vk/auth/get_access_token?user_id='+user_id.to_s
        expect(last_response.status).to eq 200
        actual_access_token = JSON.parse(last_response.body)['access_token']
        expect(actual_access_token).to eq access_token
      end
    end


  end


end