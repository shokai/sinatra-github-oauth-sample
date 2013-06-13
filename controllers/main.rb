get '/' do
  if @user = user_info
    if @github = Cache["github"].get(@user.name)
      $logger.info "cache hit (#{@user.name}'s repos and gists)"
    else
      $logger.info "get #{@user.name}'s repos and gists"
      client = Octokit::Client.new :oauth_token => @user.oauth_token
      @github = {"repos" => client.repos, "gists" => client.gists}
      Cache["github"].set @user.name, @github, :expire => 3600
    end
  end
  haml :index
end

get '/style.css' do
  scss :style
end
