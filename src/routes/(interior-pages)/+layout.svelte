<script lang="ts">
	import '$lib/css/globals.css';
	import { user, getCurrentUser } from '$lib/stores/auth.svelte';
	import { getJoinedServers, serverStore } from '$lib/stores/servers.svelte';
	import Header from '$lib/components/Header.svelte';
	import { notifications, pushNotifications } from '$lib/stores/notifications.svelte';
	import Notification from '$lib/components/Notification.svelte';

	let { children } = $props();
	let isUserLoggedIn = $derived(user.name !== undefined);
	$inspect(serverStore).with(console.trace);
	$effect(() => {
		getCurrentUser();
		getJoinedServers();
	});
	// <button onclick={() => pushNotifications('soul soul soul')}>push</button>
</script>

<main>
	<Header />
	{#if isUserLoggedIn}
		<div
			class="col-start-1 col-end-2 row-span-2 flex h-full flex-col gap-3 border-r-2 border-r-slate-900 pl-4 pr-2 pt-3"
		>
			{#each serverStore.serverData as server}
				<a href={`/${server.serverId}`} class="">
					<div
						class="leading-2 grid h-10 w-10 place-items-center rounded-full bg-indigo-500 p-2 font-mono text-xl font-bold capitalize"
					>
						{server.serverName[0]}
					</div>
				</a>
			{/each}
		</div>
	{/if}
	{@render children()}
	<div class="absolute bottom-12 right-12 flex w-fit flex-col-reverse gap-4 overscroll-x-none">
		{#each notifications.current as n}
			<Notification>
				{n}
			</Notification>
		{/each}
	</div>
</main>

<style scoped>
main {
  display: grid;
  height: 100dvh;
  grid-auto-flow: column;
  grid-auto-columns: 4rem 13rem auto;
  grid-auto-rows: min-content 1fr;
}
</style>
