# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  :port           => ENV['587'],
  :address        => ENV['smtp.mailgun.org'],
  :user_name      => ENV['postmaster@app32675440.mailgun.org'],
  :password       => ENV['da6d10d1aa6ef13e7c89cba66788f82c'],
  :domain         => 'dailywordguess.herokuapp.com',
  :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp