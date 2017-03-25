class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @eligibilities = Eligibility.where(:schedule_id => params[:schedule_id])
    @schedule = Schedule.find(params[:schedule_id])
    if can? :new_all, Placement::Application and current_user.student
        eligible=false
        @studentapp = Student.where(:user_id => current_user.id).first
        @eligibilities.each do |eligibility|
          if (@studentapp.branch == eligibility.branch and (@studentapp.cgpa >= eligibility.cgpa_min) and (@studentapp.cgpa <= eligibility.cgpa_max))
            eligible=true
          end
        end
      if !eligible
        redirect_to  "/schedules/#{@schedule.id}", :flash=>{:notice=>"You don't match any eligiblity criteria, you cannot apply"}
      end
    else
      redirect_to root_url, :flash=>{:notice=>"Only students are allowed to apply"}
    end
    session[:schedule] = @schedule.id
    @application = Application.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)
    if can? :create_all, Placement::Application
      @student1 = Student.find(@application.student_id)
      if !(@student1 and @studentapp and @student1.branch_id == @studentapp.branch_id)
        redirect_to "/hrms/placement", :flash=>{:alert=>"You are not allowed to create this application"}
      end  
    elsif current_user.student
      @studentapp = Student.where(:user_id => current_user.id).first
      @application.student_id = @studentapp.id  
    end 
    schedule = session[:schedule]
    @application.schedule_id = schedule
    session[:schedule] = nil
    @application.save
    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:student_id, :schedule_id, :accepted)
    end
end
