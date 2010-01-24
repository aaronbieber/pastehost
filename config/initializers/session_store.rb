# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_new_rails_session',
  :secret      => '4fbd2912a25db1bf2003e57dcfe92466614242f86233dfb195db07de11e9ed0ce36fcd52838a5c6cddb2b9bc66be1d199c219e434332d3eb7eb62e19276d6801'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
