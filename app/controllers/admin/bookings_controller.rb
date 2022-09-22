class Admin::BookingsController < Admin::AdminController
  def index
    @bookings = Booking.order(:created_at)
  end

  def edit
  end

  def update
  end
end
