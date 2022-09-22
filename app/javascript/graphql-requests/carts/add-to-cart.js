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
  });
}
