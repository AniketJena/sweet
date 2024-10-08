import axios from "axios";

type Tserver = {
  serverId: string
  serverName: string
  isAdmin: boolean
}
type Tchannel = {
  id: string
  name: string
  serverId: string
}
export let serverStore = $state({
  serverData: [] as Tserver[],
  currentChannelData: [] as Tchannel[]
})

export const getJoinedServers = async () => {
  const res = await axios.get(`${import.meta.env.VITE_SERVER_URL}/servers/joined-servers`, {
    withCredentials: true
  });
  serverStore.serverData = res.data
}

export const getServerChannels = async (serverId: string) => {
  const res = await axios.get(`${import.meta.env.VITE_SERVER_URL}/servers/${serverId}`, {
    withCredentials: true
  });
  serverStore.currentChannelData = res.data
}
