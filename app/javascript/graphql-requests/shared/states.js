import apolloClient from "../../apollo";
import { STATES } from "../../graphql/queries";

export default function states({ countryCode }) {
  return apolloClient.query({
    query: STATES,
    variables: {
      countryCode,
    },
  });
}
