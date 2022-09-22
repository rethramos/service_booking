import apolloClient from "../../apollo";
import { PLACE_BOOKINGS } from "../../graphql/mutations";

export default function placeBookings({ receiptId }) {
  return apolloClient.mutate({
    mutation: PLACE_BOOKINGS,
    variables: {
      input: {
        receiptId,
      },
    },
  });
}
