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
    update: (cache, { data: { placeBookings } }) => {
      if (placeBookings.__typename !== "Receipt") {
        return;
      }

      // update user.cart with the new cart ref/id
      const userCacheId = `User:${placeBookings.user.id}`;

      cache.modify({
        id: userCacheId,
        fields: {
          cart(existingCart = {}, { toReference }) {
            return toReference(placeBookings.user.cart);
          },
        },
      });
    },
  });
}
