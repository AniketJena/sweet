import axios from "axios";

export let user= $state({
  name: undefined
})
export const getCurrentUser = async () => {
  const res = await axios.get(`${import.meta.env.VITE_SERVER_URL}/auth/me`, {
    withCredentials: true
  })
  if (user.name !== res.data.userName) {
    user.name = res.data.userName
  }
}
