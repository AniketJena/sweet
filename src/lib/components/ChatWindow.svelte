<script lang="ts">
	import axios from 'axios';

	const { serverId, channelId } = $props();
	const socket = $state(new WebSocket(`ws://localhost:3000/ws/${serverId}/${channelId}`));
	type Tmessage = {
		id?: string;
		content: string;
		createdAt?: Date;
		authorId?: string;
		channelId?: string;
	};
	let messages = $state<Tmessage[]>([]);

	const getChannelMessages = async () => {
		const res = await axios.get(`${import.meta.env.VITE_SERVER_URL}/servers/channel/${channelId}`, {
			withCredentials: true
		});
		messages = res.data;
		scrollToBottom();
	};

	let chatContainer: HTMLDivElement;

	const scrollToBottom = () => {
		if (chatContainer) {
			chatContainer.scrollTop = chatContainer.scrollHeight;
		}
	};

	const onNewMessage = () => {
		socket.onmessage = (ev) => {
			const m = JSON.parse(ev.data) as Tmessage;
			messages = [...messages, m];
		};
	};

	$effect(() => {
		getChannelMessages().then(() => {
			scrollToBottom();
		});
	});

	$effect(() => {
    onNewMessage()
    messages && scrollToBottom()
	});
</script>

<div class="col-start-3 col-end-4" id="Chat">
	<div
		bind:this={chatContainer}
		class="row-start-1 row-end-2 h-[calc(100dvh-8rem)] overflow-y-scroll scrollbar-thin scrollbar-track-transparent scrollbar-thumb-indigo-500"
	>
		<div class="grid justify-items-end gap-2 p-2">
			{#each messages as m}
				<div class="min-w-36 rounded-lg rounded-br-none border-2 border-slate-900 p-4">
					<p>{m.content}</p>
				</div>
			{/each}
		</div>
	</div>
	<input
		class="row-start-2 row-end-3 m-3 h-12 resize-none rounded border-none bg-slate-900 p-3 outline-none"
		onkeyupcapture={(e) => {
			if (e.key === 'Enter') {
				socket.send(e.currentTarget.value);
				e.currentTarget.value = '';
			}
		}}
	/>
</div>

<style scoped>
	#Chat {
		display: grid;
		gap: 0.25rem;
		grid-auto-rows: auto 4rem;
	}
</style>
