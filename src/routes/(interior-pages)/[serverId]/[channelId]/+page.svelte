<script lang="ts">
	import Channels from '$lib/components/Channels.svelte';
	import ChatWindow from '$lib/components/ChatWindow.svelte';

	let { data } = $props();
</script>

<Channels serverId={data.serverId} />
<ChatWindow {...data} />
