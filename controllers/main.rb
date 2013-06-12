get '/' do
  if @user = user_info
    if @repos = Cache["repos"].get(@user.name)
      $logger.info "cache hit (#{@user.name}.repos)"
    else
      $logger.info "get #{@user.name}'s repos"
      client = Octokit::Client.new :oauth_token => @user.oauth_token
      @repos = client.repos
      Cache["repos"].set @user.name, @repos, :expire => 3600
    end
  end
  haml :index
end

get '/*.css' do |path|
  scss path.to_sym
end
