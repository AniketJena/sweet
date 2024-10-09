<script lang="ts">
	import { user } from '$lib/stores/auth.svelte';
	import { serverStore, getServerChannels } from '$lib/stores/servers.svelte';
	const { serverId } = $props();

	$effect(() => {
		getServerChannels(serverId as string);
	});
</script>

{#if user.name}
	<div class="col-start-2 col-end-3 w-52 border-r-2 border-r-slate-900 px-4 pt-3">
		<small class="mb-4 text-slate-400">CHANNELS</small>
		<div class="grid gap-3">
			{#each serverStore.currentChannelData as channel}
				<a
					href={`/${serverId}/${channel.id}`}
					data-sveltekit-preload-data="hover"
					class="text-lg font-medium"># {channel.name}</a
				>
			{/each}
		</div>
	</div>
{/if}
