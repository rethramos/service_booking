class Admin::AppointmentsController < Admin::AdminController
  before_action :set_service
  around_action :set_time_zone, only: [:create, :edit, :update]

  def new
    @appointment = @service.appointments.build
  end

  def create
    @appointment = @service.appointments.build(appointment_params)
    puts '----appointment:', @appointment.inspect, @appointment.timeslot_before_type_cast
    if @appointment.save
      flash[:success] = 'Successfully created an appointment.'
      redirect_to admin_business_service_url(@service.business_id, @service)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @appointment = @service.appointments.find(params[:id])
  end

  def update
    @appointment = @service.appointments.find(params[:id])
    if @appointment.update(appointment_params)
      flash[:success] = 'Successfully updated an appointment.'
      redirect_to admin_business_service_url(@service.business_id, @service)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_service
    @service = Service.find(
      params[:service_id] ||
      appointment_params[:service_id]
    )
  end

  def appointment_params
    params.require(:appointment).permit(:service_id, :timeslot, :max_slots)
  end

  def set_time_zone
    Time.use_zone(@service.business.timezone) { yield }
  end
end
