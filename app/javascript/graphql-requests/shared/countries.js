import apolloClient from '../../apollo'
import { COUNTRIES } from '../../graphql/queries'

export default function countries() {
  return apolloClient.query({
    query: COUNTRIES
  })
}