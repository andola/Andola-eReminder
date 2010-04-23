# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eReminder_session',
  :secret      => '14d25783d8e4e63099093abfb14c6384e98d6be5838b8f733dfacc1dfd0cf5be8d02b3cf7448f21b8554c2673d28b8cac369022f92723534ebaf5962cef2bd30'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
