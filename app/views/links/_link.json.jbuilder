json.short_url full_short_url(link)
json.original_url link.url
json.extract! link, :alias, :hits, :created_at
json.earnings link.statistics.sum(:publisher_earn)
json.delete_url url_for(link)