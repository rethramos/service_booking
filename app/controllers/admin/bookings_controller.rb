class Admin::BookingsController < Admin::AdminController
  before_action :set_booking, only: [:edit, :update]
  before_action :set_options, only: [:edit, :update]

  def index
    @bookings = Booking.order(:created_at)
  end

  def edit
  end

  def update
    status = BookingStatus.find(booking_params[:booking_status_id])
    if @booking.update_attribute(:booking_status_id, status.id)
      flash[:success] = 'Succesfully updated a booking'
      redirect_to admin_bookings_path
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    flash.now[:danger] = 'Failed to update a booking'
    render :edit, status: :unprocessable_entity
    
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_options
    @booking_status_options = BookingStatus.all.map {|s| [s.name, s.id]}
  end

  def booking_params
    params.require(:booking).permit(:booking_status_id)
  end
end
