import gql from "graphql-tag";
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
      const cartItemRef = cache.identify(addToCart)

      cache.modify({
        id: cartId,
        fields: {
          cartItems(existingCartItems = [], { readField, toReference }) {
            if (
              existingCartItems.some((ref) => readField("id", ref) == addToCart.id)
            ) {
              return existingCartItems;
            }

            return [...existingCartItems, cartItemRef];
          },
        },
      });
      console.log({cartId, cartItemRef, addToCart})
    },
  });
}
