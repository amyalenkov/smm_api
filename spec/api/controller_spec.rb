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

    context 'group endpoint' do
      it 'should create analyse group' do
        group_id = 123
        start_time = DateTime.now
        finish_time = DateTime.now.next_month
        post '/vk/group/create_analyse', group_id: group_id, start_time: start_time, finish_time: finish_time
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['group_id']).to eq group_id.to_s
      end

      it 'should update analyse group' do
        group_id = 123
        start_time = DateTime.now
        finish_time = DateTime.now.next_month
        data = '{"xz": "some data"}'
        post '/vk/group/create_analyse', group_id: group_id, start_time: start_time, finish_time: finish_time,
                                         data: data
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['group_id']).to eq group_id.to_s

        put '/vk/group/update_analyse', group_id: group_id, data: data
        expect(last_response.status).to eq 200
        expect(JSON.parse(last_response.body)['data']).to eq data.to_s
      end

      it 'should return vk group' do
        group_id = LoadData.create_analyse_group['group_id']
        get '/vk/group/get', group_id: group_id
        expect(last_response.status).to eq 200
        expect(JSON.parse(last_response.body)['group_id']).to eq group_id.to_s
      end

      it 'should return 404 if vk group is not found' do
        group_id = 34434
        get '/vk/group/get', group_id: group_id
        expect(last_response.status).to eq 404
      end

      it 'should return all vk group' do
        group_id_1 = LoadData.create_analyse_group['group_id']
        group_id_2 = LoadData.create_analyse_group['group_id']
        get '/vk/group/get_all'
        expect(last_response.status).to eq 200
        body = JSON.parse(last_response.body)
        expect(body.find {|r| r['group_id'] == group_id_1}['group_id']).to eq group_id_1.to_s
        expect(body.find {|r| r['group_id'] == group_id_2}['group_id']).to eq group_id_2.to_s
      end

    end

  end


end