json.short_url root_url(only_path: false) + link.alias
json.original_url link.url
json.extract! link, :alias, :hits, :created_at
json.delete_url url_for(link)