<script lang="ts">
	const { serverId, channelId } = $props();
	const socket = new WebSocket(`ws://localhost:3000/ws/${serverId}/${channelId}`);
	let messages = $state<string[]>([]);
	$effect(() => {
		socket.onmessage = (ev) => {
			const m = JSON.parse(ev.data);
			messages.push(m.msg);
		};
	});
</script>

<div class="flex flex-col col-start-3 col-end-4 bg-slate-900">
	<div class="flex-1">
		{#each messages as m}
			<div>{m}</div>
		{/each}
	</div>
	<input
		type="text"
		class="bg-inherit ring-1 rounded p-4 w-full"
		onkeyupcapture={(e) => {
			e.key === 'Enter' && socket.send(e.currentTarget.value);
		}}
	/>
</div>
