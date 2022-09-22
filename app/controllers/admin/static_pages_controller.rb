class Admin::StaticPagesController < Admin::AdminController
  def home
    @users = User.where admin: false
    @user_count = @users.count

    @served_bookings = Booking.where(booking_status: BookingStatus.served).count
    @cancelled_bookings = Booking.where(booking_status: BookingStatus.cancelled).count
    @pending_bookings = Booking.where(booking_status: BookingStatus.pending).count

    @most_booked_services = Booking
                            .select(:service_id)
                            .group(:service_id)
                            .order('count_service_id desc')
                            .count
                            .map { |service_id, n| { service: Service.find(service_id), count: n } }
  end
end
