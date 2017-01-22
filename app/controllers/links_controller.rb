class LinksController < ApplicationController
  before_action :set_link, only: [:destroy]
  before_action :set_link_by_alias, only: [:visit_in,:visit_out]
  skip_before_action :authenticate_user!, only: [:visit_in,:visit_out]
  layout :resolve_layout

  # GET /links
  # GET /links.json
  def index
    sort = params[:sort] || :id
    order = params[:order] || :desc
    limit = params[:limit].to_i || 10
    limit = (limit <= 100) ? limit : 10
    @links = current_user.links.all
                  .search(params[:search])
                  .order(sort => order)
                  .offset(params[:offset])
                  .limit(limit)
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.new(link_params)

    respond_to do |format|
      if @link.save
        format.json { render :show, status: :created, location: @link }
      else
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /[A-Za-z0-9]
  def visit_in
    @link.real_hits = (@link.real_hits).to_i + 1
    @link.save
  end

  # POST /[A-Za-z0-9]
  def visit_out
    if !verify_recaptcha || request.get?
      redirect_to "/#{@link.alias}"
    else
      @link.new_visit current_visit
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = current_user.links.find(params[:id])
    end

    def set_link_by_alias
      @link = Link.find_by! alias: params[:alias]
    end

    def resolve_layout
      case action_name
      when 'visit_in', 'visit_out'
        'adlink_layout'
      else
        'application'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url, :sort, :search, :order, :offset, :limit)
    end
end
