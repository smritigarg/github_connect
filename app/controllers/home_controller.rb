require 'rest-client'

class HomeController < ApplicationController
  def index
  end

  def profile
    # Retrieve temporary authorization grant code
    session_code = request.env['rack.request.query_hash']['code']

    # POST Auth Grant Code + CLIENT_ID/SECRECT in exchange for our access_token
    response = RestClient.post 'https://github.com/login/oauth/access_token',
      # POST payload
      {:client_id => ENV['CLIENT_ID'],
      :client_secret => ENV['CLIENT_SECRET'],
      :code => session_code},
      # Request header for JSON response
      {accept: :json}

      #Parse access_token from JSON response
      access_token = JSON.parse(response)['access_token']

      # Initialize Octokit client with user access_token
      client = Octokit::Client.new(:access_token => access_token)

      # Create user object for less typing
      user = client.user

      # Access user data
      @profile_data = {:user_photo_url => user.avatar_url,
                        :user_login => user.login,
                        :user_name => user.name,
                        :user_id => user.id }
  end
end
