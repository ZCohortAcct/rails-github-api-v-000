class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 
        'client_id': ENV['GITHUB_CLIENT_ID'], 
        'client_secret': ENV['GITHUB_CLIENT_SECRET'], 
        'code': params[:code] 
      }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
    token = body['access_token']

    session[:token] = token;
    redirect_to root_path
  end
end
