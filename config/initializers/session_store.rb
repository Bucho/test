# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pictures_session',
  :secret      => 'aba12caa75dabb559dcab5fe68fe32936550d2956be953652252a4f259a714a6fe6c95a1aae865332e143a774f2220223974d3588eee9f0a36c8951e0211b303'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
