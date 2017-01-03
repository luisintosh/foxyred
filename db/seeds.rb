# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
    # email, pass, confirm pass, role, first_name, last_name, address
    ['admin@foxy.red', '123456', '123456', 'admin', 'Luis', 'Mendieta', 'Internet'],
    ['anon@foxy.red', '123456', '123456', 'user', 'Anonymous', 'User', 'Internet']
]

settings = [
    # General
    ['site_name', 'Foxy.red - Shorten URLs and earn money'],
    ['site_description', 'Earn money for each visitor to your shortened links with foxy.red! We pay for each visit to your short link.'],
    ['default_language', 'en'],
    ['site_languages', 'en'],
    ['logo_url', ''],
    ['enable_ads', 'true'],
    ['referral_percentage', '20'],
    ['min_withdrawal_amount', '5'],
    ['paid_views_per_day_for_campaign', '1'],
    # Links 
    ['enable_interstitial_ads', 'true'],
    ['enable_banner_ads', 'true'],
    ['enable_popup_ads', 'true'],
    ['display_home_shortening_box', 'true'],
    ['mass_shrinker_limit', '30'],
    ['disallowed_domains', 'localhost,127.0.0.1,0.0.0.0'],
    ['alias_length', '6'],
    # Integration
    ['analytics_id', 'UA-XXXXXX'],
    ['recaptcha_public', '6LedexAUAAAAAJDY6uA1cVo0iucn6oiOR7AMl8pZ'],
    ['recaptcha_secret', '6LedexAUAAAAAPJwhf5hLwpnjcByHQOy5ZXA7OdM'],
    # Payment
    ['paydays', '1,16'],
    ['currency_code', 'USD'],
    ['currency_symbol', '$'],
    ['enable_paypal', 'true'],
    ['paypal_email', ''],
    ['enable_paypal_sandbox', 'false'],
    ['enable_payza', 'false'],
    ['payza_email', ''],
    ['enable_coinbase', 'false'],
    ['coinbase_apikey', ''],
    ['coinbase_apisecret', ''],
    ['enable_coinbase_sandbox', 'false'],
    # Social media
    ['facebook_appid', ''],
    ['facebook_url', ''],
    ['twitter_url', ''],
    ['googleplus_url', ''],
    # Email
    ['admin_email', 'admin@foxy.red'],
    ['from_email', 'no_reply@foxy.red'],
    ['support_email', 'support@foxy.red'],
    ['dcma_email', 'dcma@foxy.red']
]

pages = [
    ['Publisher Rates', 'payout-rates', '', true],
    ['Advertising Rates', 'advertising-rates', '', true],
    ['DMCA', 'dcma', '', true],
    ['Privacy Policy', 'privacy', '', true],
    ['Terms of Use', 'terms', '', true]
]

payout_rates = [
    ['Australia', 'au', 4.6],
    ['United Kingdom', 'gb', 4.24],
    ['United States', 'us', 4.1],
    ['Norway', 'no', 4],
    ['Sweden', 'se', 3.36],
    ['Canada', 'ca', 3.27],
    ['South Africa', 'za', 1.83],
    ['Finland', 'fi', 1.83],
    ['Poland', 'pl', 1.78],
    ['Ireland', 'ie', 1.65],
    ['New Zealand', 'nz', 1.65],
    ['Netherlands', 'nl', 1.65],
    ['Brazil', 'br', 1.6],
    ['All Other Country', 'xx', 1.5],
]

users.each do |a, b, c, d, e, f, g|
    User.create(email: a, password: b, password_confirmation: c, role: d, first_name: e, last_name: f, address: g)
end

settings.each do |n, v|
    Option.create(name: n, value: v)
end

pages.each do |a, b, c, d|
    Page.create(title: a, slug: b, content: c, published: d)
end

payout_rates.each do |a, b, c|
    PayoutRate.create(country: a, country_code: b, earn: c)
end