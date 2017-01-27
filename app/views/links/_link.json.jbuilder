json.short_url full_short_url(link)
json.original_url link.url
json.extract! link, :alias, :hits, :created_at
json.earnings (Option.get(:currency_symbol) + link.statistics.sum(:publisher_earn).to_s)
json.delete_url url_for(link)