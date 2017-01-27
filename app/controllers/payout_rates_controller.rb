class PayoutRatesController < ApplicationController
  before_action :admin_only
  before_action :set_payout_rate, only: [:show, :edit, :update, :destroy]

  # GET /payout_rates
  # GET /payout_rates.json
  def index
    @payout_rates = PayoutRate.all
  end

  # GET /payout_rates/1
  # GET /payout_rates/1.json
  def show
  end

  # GET /payout_rates/new
  def new
    @payout_rate = PayoutRate.new
  end

  # GET /payout_rates/1/edit
  def edit
  end

  # POST /payout_rates
  # POST /payout_rates.json
  def create
    @payout_rate = PayoutRate.new(payout_rate_params)

    respond_to do |format|
      if @payout_rate.save
        format.html { redirect_to @payout_rate, notice: 'Payout rate was successfully created.' }
        format.json { render :show, status: :created, location: @payout_rate }
      else
        format.html { render :new }
        format.json { render json: @payout_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payout_rates/1
  # PATCH/PUT /payout_rates/1.json
  def update
    respond_to do |format|
      if @payout_rate.update(payout_rate_params)
        format.html { redirect_to @payout_rate, notice: 'Payout rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @payout_rate }
      else
        format.html { render :edit }
        format.json { render json: @payout_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payout_rates/1
  # DELETE /payout_rates/1.json
  def destroy
    @payout_rate.destroy
    respond_to do |format|
      format.html { redirect_to payout_rates_url, notice: 'Payout rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payout_rate
      @payout_rate = PayoutRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payout_rate_params
      params.require(:payout_rate).permit(:country, :country_code, :earn)
    end

    def admin_only
      unless current_user.admin?
        redirect_to root_path, :alert => "Access denied."
      end
    end
end
