import apolloClient from "../../apollo";
import { CREATE_RECEIPT } from "../../graphql/mutations";

export default function createReceipt({
  firstName,
  lastName,
  email,
  contactNumber,
  address: { lineOne, lineTwo, city, province, country, postalCode },
  paymentOptionId,
}) {
  return apolloClient.mutate({
    mutation: CREATE_RECEIPT,
    variables: {
      input: {
        firstName,
        lastName,
        email,
        contactNumber,
        address: {
          lineOne,
          lineTwo,
          city,
          province,
          country,
          postalCode,
        },
        paymentOptionId,
      },
    },
  });
}
