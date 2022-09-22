import apolloClient from "../../apollo";
import { PAYMENT_OPTIONS } from "../../graphql/queries";

export default function paymentOptions() {
  return apolloClient.query({
    query: PAYMENT_OPTIONS,
  });
}
