# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
    # email, pass, confirm pass, role, first_name, last_name, address
    ['admin@foxy.red', '123456', '123456', 'admin', 'Luis', 'Mendieta', 'Internet', '000000'],
    ['anon@foxy.red', '123456', '123456', 'user', 'Anonymous', 'User', 'Internet', '111111']
]

settings = [
    # General
    ['string', 'site_name', 'Foxy.red - Shorten URLs and Make Money Online!'],
    ['string', 'site_description', 'Monetize your Website, Facebook or Twitter, use foxy.red link shortener to make money online. We pay for each visit to your short link.'],
    ['string', 'default_language', 'en'],
    ['string', 'site_languages', 'en'],
    ['string', 'logo_url', ''],
    ['boolean', 'enable_ads', 'true'],
    ['integer', 'referral_percentage', '20'],
    ['integer', 'min_withdrawal_amount', '5'],
    ['integer', 'paid_views_per_day_for_campaign', '1'],
    # Links 
    ['boolean', 'enable_banner_ads', 'true'],
    ['boolean', 'enable_popup_ads', 'true'],
    ['boolean', 'enable_mobile_ads', 'true'],
    ['boolean', 'display_home_shortening_box', 'true'],
    ['integer', 'mass_shrinker_limit', '30'],
    ['string', 'disallowed_domains', 'localhost,127.0.0.1,0.0.0.0'],
    ['integer', 'alias_length', '6'],
    # Integration
    ['string', 'analytics_id', 'UA-XXXXXX'],
    ['string', 'recaptcha_public', '6LedexAUAAAAAJDY6uA1cVo0iucn6oiOR7AMl8pZ'],
    ['string', 'recaptcha_secret', '6LedexAUAAAAAPJwhf5hLwpnjcByHQOy5ZXA7OdM'],
    ['string', 'facebook_appid', ''],
    ['string', 'facebook_thumbnail_url', ''],
    # Payment
    ['string', 'paydays', '1,16'],
    ['string', 'currency_code', 'USD'],
    ['string', 'currency_symbol', '$'],
    ['boolean', 'enable_paypal', 'true'],
    ['boolean', 'enable_payza', 'false'],
    ['boolean', 'enable_payoneer', 'false'],
    ['boolean', 'enable_bitcoin', 'false'],
    ['boolean', 'enable_webmoney', 'false'],
    ['boolean', 'enable_skrill', 'false'],
    # Social media
    ['string', 'facebook_url', '#'],
    ['string', 'twitter_url', '#'],
    ['string', 'googleplus_url', '#'],
    # Email
    ['email', 'admin_email', 'admin@foxy.red'],
    ['email', 'payments_email', 'payments@foxy.red'],
    ['email', 'notifications_email', 'no-reply@foxy.red'],
    ['email', 'support_email', 'support@foxy.red']
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
    ['All Other Country', 'xx', 1.6],
]

users.each do |a, b, c, d, e, f, g, h|
    User.create(email: a, password: b, password_confirmation: c, role: d, first_name: e, last_name: f, address: g, referral_code: h, confirmed_at: DateTime.now)
end

settings.each do |t, n, v|
    Option.create(datatype: t, name: n, value: v)
end

pages.each do |a, b, c, d|
    Page.create(title: a, slug: b, content: c, published: d)
end

payout_rates.each do |a, b, c|
    PayoutRate.create(country: a, country_code: b, earn: c)
end