class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    puts "***********params#{params}"
    @quotes = Quote.search(params[:search])
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show

  end

  # GET /quotes/1
  # GET /quotes/1.json
  def search
    puts "searching"
    @quotes = [Quote.first]
    # redirect_to , status: :found
    # respond_to do |format|
    #   format.html { redirect_to quotes_path, notice: "#{Quotes.all.count} quotes found matching your search criteria" }
    #   format.json { render :show, status: :created, location: @quote }
    # end
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @user = current_user
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.user_id = current_user
    respond_to do |format|
      if @quote.save
        b=Bot.new(@quote)
        rates = b.get_rates
        format.html { redirect_to @quote, notice: rates }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to edit_quote_path(@quote), notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:program, :mga, :mga_contact, :agency, :agent, :effective_date, :insured_name, :state_of_residence, :cc1, :cc1_receipts, :cc1_receipts, :cc2, :cc2_receipts, :cc2_receipts, :cc3, :cc3_receipts, :cc3_receipts, :cc4, :cc4_receipts, :cc4_receipts, :limits, :self_insured_retentions, :has_loss_runs, :years_in_business, :years_in_trade, :is_guardian_renewal, :sub_out_percentage, :sub_out_percentage, :broker_fee, :broker_fee, :retail_producer_fee, :retail_producer_fee, :blanket_endorsements, :ai, :ai_completed_ops_commercial, :ai_permit_endorsement, :exclusion_work_for_association, :other_entity_exclusion, :per_project_aggregate, :plex_endorsement, :primary_wording, :terrorism, :torch_down, :tract_homes, :waiver, :user_id, :state, :premium, :program_fee, :inspection_fee, :surplus_lines_tax, :stamping_fee, :total_policy_cost, :old_policy_number, :renewal_loss_free)
    end
end
