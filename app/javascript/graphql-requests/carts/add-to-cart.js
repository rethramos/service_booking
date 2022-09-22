import apolloClient from "../../apollo";
import { ADD_TO_CART } from "../../graphql/mutations";

export default function addToCart({ serviceId, appointmentId, addon, slots }) {
  return apolloClient.mutate({
    mutation: ADD_TO_CART,
    variables: {
      input: {
        serviceId,
        appointmentId,
        addon,
        slots,
      },
    },
    update: (cache, { data: { addToCart } }) => {
      if (addToCart.__typename !== "CartItem") {
        return;
      }

      const cartId = `Cart:${addToCart.cart.id}`;

      cache.modify({
        id: cartId,
        fields: {
          cartItems(existingCartItems = [], { readField, toReference }) {
            if (
              existingCartItems.some((ref) => {
                return readField("id", ref) == addToCart.id;
              })
            ) {
              return existingCartItems;
            }

            return [...existingCartItems, toReference(addToCart)];
          },
        },
      });
    },
  });
}
