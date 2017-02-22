class LinksController < ApplicationController
  before_action :set_link, only: [:destroy]
  before_action :set_link_by_alias, only: [:visit_step1,:visit_step2]
  skip_before_action :authenticate_user!, only: [:visit_step1,:visit_step2,:disable_adblock]
  layout :resolve_layout
  helper_method :full_short_url
  helper_method :mobile_device?

  # GET /links
  # GET /links.json
  def index
    sort = params[:sort] || :id
    order = params[:order] || :desc
    limit = params[:limit].to_i || 10
    limit = (limit <= 100) ? limit : 10
    @links = current_user.links.all
                  .where('url LIKE ? OR alias LIKE ? OR created_at::text LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
                  .order(sort => order)
                  .offset(params[:offset])
                  .limit(limit)
  end

  # POST /links
  # POST /links.json
  def create
    # Delete spaces from url
    link_params[:url].gsub!(' ','')
    @link = Link.where(url: link_params[:url], user_id: current_user).last
    @link ||= current_user.links.new(link_params)

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
  def visit_step1
    @view_type = 'link-in'
    @csymbol = Option.get :currency_symbol
    @ccode = Option.get :currency_code
    @min_pr = PayoutRate.where(country_code: :xx).last.earn.to_s
    @link.real_hits = (@link.real_hits).to_i + 1
    @link.save
    @post = Post.all.sample
  end

  # POST /[A-Za-z0-9]
  def visit_step2
    @view_type = 'link-out'
    @csymbol = Option.get :currency_symbol
    @ccode = Option.get :currency_code
    @min_pr = PayoutRate.where(country_code: :xx).last.earn.to_s
    @post = Post.all.sample
    # adblock detect (assets/javascript/blocker/adb-detecter.js)
    if cookies[:ABID] && cookies[:ABID].length < 10
      redirect_to disable_adblock_path
    elsif !verify_recaptcha || request.get?
      redirect_to "/#{@link.alias}"
    else
      @link.new_visit current_visit
    end
  end

  # GET /s/:referral_code?url=http://...
  def quick_link
    user = User.find_by! referral_code: params[:referral_code]
    @link = Link.where(url: params[:url], user_id: user).last
    @link ||= user.links.new(url: params[:url])

    if @link.save
      redirect_to "/#{@link.alias}"
    else
      redirect_to root_path
    end
  end

  # GET /api/:referral_code?url=http://..
  def api_link
    user = User.find_by! referral_code: params[:referral_code]
    @link = Link.where(url: params[:url], user_id: user).last
    @link ||= user.links.new(url: params[:url])

    if @link.save
      render plain: "#{full_short_url(@link)}"
    else
      render plain: 'Error', status: :internal_server_error
    end
  end

  def disable_adblock
    @view_type = 'blocker'
    @page_title = "Please disable AdBlock to continue | #{Option.get :site_name}"
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
      when 'visit_step1', 'visit_step2', 'disable_adblock'
        'adlink_layout'
      else
        'application'
      end
    end

    def full_short_url(link)
      URI.join(root_url(only_path: false), link.alias).to_s
    end

    def mobile_device?
      if session[:mobile_param]
        session[:mobile_param] == "1"
      else
        request.user_agent =~ /Mobile|webOS/
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url, :sort, :search, :order, :offset, :limit)
    end
end
