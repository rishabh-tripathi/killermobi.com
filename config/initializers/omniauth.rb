Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'dE0o6Tx9u5Ls3q5K8t6eA', 'WBPdaSmP2kIWIcZk1CTn53WHydlMaVrMk5yevTZbyA'
  provider :facebook, '163152080370507', 'e7a10e1a03d464660885954473ef452a', {:scope => "email, user_about_me, user_birthday, user_hometown, user_interests, user_likes, user_location, user_photos, friends_birthday, friends_hometown, friends_location, publish_stream, publish_actions, offline_access"}
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  #provider :linkedin, "consumer_key", "consumer_secret"
end
