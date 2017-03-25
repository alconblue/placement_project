class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @eligibilities = Eligibility.where(:schedule_id => @schedule.id)
  end

  # GET /schedules/new
  def new
    if current_user.company
      @schedule = Schedule.new
    else
      redirect_to "/companies", :flash=>{:notice => "You aren't allowed to create a schedule"}
    end    
  end

  # GET /schedules/1/edit
  def edit
    @company = Company.find(@schedule.company_id)
    if !(current_user.admin or current_user.id == @company.id)
      redirect_to "/companies", :flash=>{:notice => "You aren't allowed to edit the schedule."}
    end
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @company = Company.where(:user_id => current_user.id).first
    @schedule.company_id = @company.id
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @company = Company.find(@schedule.company_id)
    if !(current_user.admin or current_user.id == @company.id)
      redirect_to "/companies", :flash=>{:notice => "You aren't allowed to destroy the schedule."}
    else  
      @schedule.destroy
      respond_to do |format|
        format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:company_id, :date, :visited)
    end
end
