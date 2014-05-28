# Be sure to restart your server when you modify this file.

Killermobi::Application.config.session_store :cookie_store, :key => '_killermobi_session'
Killermobi::Application.config.action_controller.session = {
    :secret      => 'bTJ5urQudWCFSLU8IPtY7xyrf5FjpMyP1PZml61P6NU'
  }

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Killermobi::Application.config.session_store :active_record_store
