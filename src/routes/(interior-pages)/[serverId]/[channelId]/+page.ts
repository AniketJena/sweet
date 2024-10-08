import type { PageLoad } from "../$types"

export const load: PageLoad = ({ params }) => {

  return {
    serverId: params.serverId as string,
    channelId: params.channelId as string
  }
}
