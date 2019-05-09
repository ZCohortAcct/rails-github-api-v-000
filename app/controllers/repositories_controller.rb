class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @repos = JSON.parse(resp.body)
    # binding.pry
  end

end
