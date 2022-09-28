import apolloClient from "../../apollo";
import { CITIES } from "../../graphql/queries";

export default function cities({ stateCode, countryCode }) {
  return apolloClient.query({
    query: CITIES,
    variables: {
      stateCode,
      countryCode,
    },
    fetchPolicy: "no-cache",
  });
}
