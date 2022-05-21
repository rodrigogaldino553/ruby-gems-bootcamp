# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = '6LfbaPcfAAAAABS3mWCNCqXw3rZqbqGyLyWYVDc5'
  config.secret_key = '6LfbaPcfAAAAAIdQliTc5EaMyW0TTYOHKHtoBdBi'

  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'

  # Uncomment the following lines if you are using the Enterprise API:
  # config.enterprise = true
  # config.enterprise_api_key = 'AIzvFyE3TU-g4K_Kozr9F1smEzZSGBVOfLKyupA'
  # config.enterprise_project_id = 'my-project'
end