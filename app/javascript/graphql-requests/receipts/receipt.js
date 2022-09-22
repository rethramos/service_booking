import apolloClient from "../../apollo";
import { RECEIPT } from "../../graphql/queries";

export default function receipt({ id }) {
  return apolloClient.query({
    query: RECEIPT,
    variables: { id },
  });
}
