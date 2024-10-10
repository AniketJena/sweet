<script lang="ts">
	import Channels from '$lib/components/Channels.svelte';
	import ChatWindow from '$lib/components/ChatWindow.svelte';
	import { serverStore } from '$lib/stores/servers.svelte.js';

	let { data } = $props();

	let server = $derived(serverStore.serverData.find((s) => s.serverId === data.serverId));
	let channel = $derived(serverStore.currentChannelData.find((c) => c.id === data.channelId));
</script>

<svelte:head>
	<title>{server?.serverName} | {channel?.name}</title>
</svelte:head>
<Channels serverId={data.serverId} />
<ChatWindow {...data} />
