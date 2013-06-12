get '/' do
  @user = user_info
  if @user
    client = Octokit::Client.new :oauth_token => @user.oauth_token
    @repos = client.repos
    @gists = client.gists
  end
  haml :index
end

get '/*.css' do |path|
  scss path.to_sym
end
