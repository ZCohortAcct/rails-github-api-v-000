class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @repos = JSON.parse(resp.body)
  end

    def create
      # replace session[:token] w/persona access token & this will function as expected
      resp = Faraday.post 'https://api.github.com/user/repos' do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = "token #{session[:token]}"
        req.body = {'name': params[:name]}
      end

      redirect to root_path
    end
# curl -i -X POST https://api.github.com/user/repos \
# -H "Authorization: token 4e880bff89dd7ff575932f0ad69535d3388f17a8" \
# -d @- << EOF
# {
#   "name": "z-test-blog",
#   "auto_init": true,
#   "private": true,
#   "gitignore_template": "nanoc"
# }
# EOF
# binding.pry

#7f5ee4936859c5da2adf0844745b4e1e58b6b8b4
# response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => 'token ${session[:token]}'", 'Accept' => 'application/json'}
#       binding.pry
#     end
end
