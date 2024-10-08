<script lang="ts">
	import Channels from '$lib/components/Channels.svelte';
	import { getServerChannels } from '$lib/stores/servers.svelte';

	let { data } = $props();

	$effect(() => {
		getServerChannels(data.serverId);
	});
</script>

<svelte:head>
	<title>Server</title>
</svelte:head>

<Channels serverId={data.serverId} />
