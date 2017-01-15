class LinksController < ApplicationController
  before_action :set_link, only: [:destroy]

  # GET /links
  # GET /links.json
  def index
    sort = params[:sort] || :id
    order = params[:order] || :desc
    limit = params[:limit] || 10
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = current_user.links.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url, :sort, :search, :order, :offset, :limit)
    end
end
