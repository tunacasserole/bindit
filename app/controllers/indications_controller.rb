class IndicationsController < ApplicationController
  before_action :set_indication, only: [:show, :edit, :update, :destroy]

  # GET /indications
  # GET /indications.json
  def index
    @indications = Indication.all
  end

  # GET /indications/1
  # GET /indications/1.json
  def show
  end

  # GET /indications/new
  def new
    @indication = Indication.new
  end

  # GET /indications/1/edit
  def edit
  end

  # POST /indications
  # POST /indications.json
  def create
    @indication = Indication.new(indication_params)

    respond_to do |format|
      if @indication.save
        format.html { redirect_to @indication, notice: 'Indication was successfully created.' }
        format.json { render :show, status: :created, location: @indication }
      else
        format.html { render :new }
        format.json { render json: @indication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indications/1
  # PATCH/PUT /indications/1.json
  def update
    respond_to do |format|
      if @indication.update(indication_params)
        format.html { redirect_to @indication, notice: 'Indication was successfully updated.' }
        format.json { render :show, status: :ok, location: @indication }
      else
        format.html { render :edit }
        format.json { render json: @indication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indications/1
  # DELETE /indications/1.json
  def destroy
    @indication.destroy
    respond_to do |format|
      format.html { redirect_to indications_url, notice: 'Indication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indication
      @indication = Indication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def indication_params
      params.require(:indication).permit(:underwriter_id, :state, :effective_date, :expire_date, :wholesale_agency_id, :retail_agency_id, :placement_fee, :employee_payroll, :owner_payroll, :total_payroll, :sub_out_commercial, :sub_out_residential, :gross_receipts_current, :description_of_operations, :type_of_contractor, :type_al_requested, :limits_selected, :insured_ops, :limits, :rating_factor, :dba, :name, :zip, :address1, :address2, :city, :email, :fax, :phone, :state_code, :gf_comments, :approval_comments, :pdf_natural_url, :pdf_tracking_url, :mgu_id)
    end
end
