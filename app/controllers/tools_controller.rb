class ToolsController < ApplicationController
  helper_method :full_short_url

  def index
    @links = Link.shrink_list_urls(params[:link_list], current_user)
  end

  private 
    def full_short_url(link)
      URI.join(root_url(only_path: false), link.alias).to_s
    end
end
