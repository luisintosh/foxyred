json.total current_user.links.all.count
json.recordsFiltered @links.count
json.rows @links, partial: 'links/link', as: :link