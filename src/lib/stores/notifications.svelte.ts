
type Tnotifications = {
  current: string[]
}

export let notifications = $state<Tnotifications>({
  current: []
})

export const pushNotifications = (message: string) => {
  notifications.current.push(message)
  setTimeout(() => {
    notifications.current.shift()
  }, 3000)
}
