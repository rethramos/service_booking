import apolloClient from "../../apollo";
import { ME } from "../../graphql/queries";

export default function me() {
  return apolloClient.query({
    query: ME,
  });
}
