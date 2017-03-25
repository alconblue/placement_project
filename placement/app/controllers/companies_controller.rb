class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @schedules = Schedule.where(:company_id => @company.id)
  end

  # GET /companies/new
  def new
    if current_user.admin
      @company = Company.new
    else
      redirect_to "/companies", :flash=>{:notice=>"You arent allowed to create a company"}      
    end  
  end

  # GET /companies/1/edit
  def edit
    if !(current_user.admin or @company.user_id == current_user.id)
      redirect_to "/companies", :flash=>{:notice=>"You aren't allowed to edit the details of this company"}
    end  
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @user = User.where(:email => @company.email).first
    @company.user_id = @user.id
    @user.student = false
    @user.admin = false
    @user.company = true
    @user.save
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    if !(current_user.admin or @company.user_id == current_user.id)
      redirect_to "/companies", :flash=>{:notice=>"You aren't allowed to destroy this company"}
    else
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :email, :user_id, :description, :poc_name, :poc_email, :poc_phone)
    end
end
