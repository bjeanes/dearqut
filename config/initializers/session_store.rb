# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dearqut_session',
  :secret      => '5cee0b5c56fe523db2e6c97afd4797309b2742827b3243041ae2a72f934d2e5e97784f7e8ab9bb1b0d22794035ac0e93cce785bb3d790875257e8b90c7fea891'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
