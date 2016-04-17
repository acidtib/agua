require 'api_constraints'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do

    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      scope "user" do
        post 'new' => 'user#create', as: :user_new
      end

      scope "story" do
        post 'new' => 'story#create', as: :story_new
      end
    end

  end
end
