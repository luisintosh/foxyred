# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( theme/css/separate/pages/login.min.css )
Rails.application.config.assets.precompile += %w( ads.scss home.scss links.scss options.css pages.scss payout_rates.scss referrals.scss adlink.scss )
Rails.application.config.assets.precompile += %w( ads.js home.js links.js options.js pages.js payout_rates.js referrals.js adlink.js )