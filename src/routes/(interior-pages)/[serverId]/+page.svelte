<script lang="ts">
	import Channels from '$lib/components/Channels.svelte';
	import { serverStore, getServerChannels } from '$lib/stores/servers.svelte';

	let { data } = $props();

	let server = $derived(serverStore.serverData.find((s) => s.serverId === data.serverId));

	$effect(() => {
		getServerChannels(data.serverId);
	});
</script>

<svelte:head>
	<title>Server | {server?.serverName}</title>
</svelte:head>

<Channels serverId={data.serverId} />
