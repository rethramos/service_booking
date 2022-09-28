import apolloClient from "../../apollo";
import { DELETE_CART_ITEM } from "../../graphql/mutations";

export default function deleteCartItem({ cartItemId }) {
  return apolloClient.mutate({
    mutation: DELETE_CART_ITEM,
    variables: {
      input: {
        cartItemId,
      },
    },
    update: (cache, { data: { deleteCartItem } }) => {
      if (deleteCartItem) {
        cache.evict({
          id: cache.identify({ __typename: "CartItem", id: cartItemId }),
        });
        cache.gc();
      }
    },
  });
}
