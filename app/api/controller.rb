require_relative '../../config/application.rb'

module App

  class Controller < Grape::API
    format :json

    resource :vk do

      desc 'analise vk group'
      params do
        requires :group_id, type: String, desc: 'id vk group'
        requires :user_id, type: String, desc: 'user id for which group analise'
        requires :start_time, type: String, desc: 'start analise time'
        requires :finish_time, type: String, desc: 'finish analise time'
      end
      post 'save_group' do
        new_vk_group = AccessToken.new(:group_id)
        new_vk_group.save
      end

      desc 'get info about vk group'
      params do
        requires :group_id, type: String, desc: 'id vk group'
      end
      get 'get_group' do
        AccessToken.get_by_group_id(params[:group_id])
      end

      desc 'get info about all vk groups'
      get 'get_groups' do
        AuthParam.all
      end

      resource :auth do
        desc 'get url for auth'
        get 'get_url' do
          VkAuthorize.get_auth_url
        end

        desc 'redirect endpoint for save access_token'
        get 'save_access_token' do
          unless params[:code].nil?
            VkAuthorize.send_code_and_save_token params[:code]

          end
        end
      end

    end
  end
end