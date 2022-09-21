import apolloClient from "../../apollo";
import { SERVICE } from "../../graphql/queries";

export default function getServiceById(id) {
  return apolloClient
    .query({
      query: SERVICEVICE,
      variables: {
        id,
      },
    })
    .then(({ data: { service } }) => {
      return service;
    });
}
