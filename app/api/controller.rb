require_relative '../../config/application.rb'

module App

  class Controller < Grape::API
    format :json

    resource :vk do

      resource :group do
        desc 'create record for analise vk group'
        params do
          requires :group_id, type: String, desc: 'id vk group'
          requires :start_time, type: String, desc: 'start analise time'
          requires :finish_time, type: String, desc: 'finish analise time'
        end
        post 'create_analyse' do
          new_vk_group = AnalyseGroup.new(group_id: params[:group_id],
                                          start_time: params[:start_time],
                                          finish_time: params[:finish_time])
          new_vk_group.save
          new_vk_group
        end

        desc 'update data for vk group'
        params do
          requires :group_id, type: String, desc: 'id vk group'
          requires :data, type: String, desc: 'analise data'
        end
        put 'update_analyse' do
          record = AnalyseGroup.find_by_group_id(params[:group_id])
          if record.nil?
            status 404
          else
            record.update_attribute(:data, params[:data])
            record
          end
        end

        desc 'get info about vk group'
        params do
          requires :group_id, type: String, desc: 'id vk group'
        end
        get 'get' do
          record = AnalyseGroup.find_by_group_id(params[:group_id])
          if record.nil?
            status 404
          else
            record
          end
        end

        desc 'get info about all vk groups'
        get 'get_all' do
          AnalyseGroup.all
        end
      end

      resource :auth do
        desc 'get url for auth'
        get 'get_url' do
          {:url => VkAuthorize.get_auth_url}
        end

        desc 'redirect endpoint for save access_token'
        get 'save_access_token' do
          unless params[:code].nil?
            VkAuthorize.send_code_and_save_token params[:code]
          end
        end

        desc 'get access_token for user'
        params do
          requires :user_id, type: String, desc: 'id for vk user'
        end
        get 'get_access_token' do
          record = VkAuthorize.get_access_token_by_user_id params[:user_id]
          if record.nil?
            status 404
          else
            {access_token: record['access_token']}
          end
        end

      end

    end

    resource :users do

      desc 'create new user'
      params do
        requires :email, type: String, desc: 'user email'
        requires :password, type: String, desc: 'user password'
      end
      post 'create' do
        if Registration.email_is_present?(params[:email])
          error!('email is present in db', 400)
        else
          user = Registration.create_user(params[:email], params[:password])
          token = ApiKey.create!(user_id: user.id)
          {access_token: token.access_token}
        end
      end

      desc 'get access token'
      params do
        requires :email, type: String, desc: 'user email'
        requires :password, type: String, desc: 'user password'
      end
      get 'login' do
        access_token = TokenHelper.create_token(params[:email], params[:password])
        if access_token.nil?
          error!('email or login is invalid', 403)
        else
          {access_token: access_token}
        end
      end

      desc 'delete access token'
      get 'logout' do
        check_auth headers['Token']
        TokenHelper.delete_token headers['Token']
      end

    end

  end
end

def check_auth(token_header)
  error!(400) if token_header.nil?
  token = ApiKey.find_by(access_token: token_header)
  error!(400) if token.nil?
  error!(400) if token.expired?
end
