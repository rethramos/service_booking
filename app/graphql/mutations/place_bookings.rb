module Mutations
  class PlaceBookings < BaseMutation
    argument :receipt_id, ID, required: true

    type Types::Booking::PlaceBookingsResultType, null: false

    def resolve(receipt_id:)
      return :unauthenticated unless (user = context[:current_user])

      cart = user.cart
      receipt = Receipt.find(receipt_id)
      default_status = BookingStatus.find_by(name: BookingStatus::PENDING)
      # for each cart item, create a booking
      # and associate it to the receipt
      bookings_to_save = cart.cart_items.map do |item|
        receipt.bookings.build(
          service: item.service,
          booking_status: default_status,
          service_name: item.service.name,
          service_appointment: item.appointment.timeslot,
          service_unit_price: item.service.unit_price,
          service_currency: item.service.currency,
          slots: item.slots,
          addon: item.addon
        )
      end

      Booking.transaction do
        bookings_to_save.each do |b|
          b.save!
        end
        # empty cart
        user.create_cart!
      end

      receipt
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors
    end
  end
end
