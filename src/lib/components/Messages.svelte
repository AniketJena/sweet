<script lang="ts">
	import ChatDate from './ChatDate.svelte';
	import Message from './Message.svelte';

	type Tmessage = {
		id: string;
		content: string;
		createdAt: Date;
		authorId: string;
		channelId: string;
		authorName: string;
	};
	const messages: Tmessage[] = $props();
</script>

<div class="grid justify-items-end p-2">
	{#each messages as m, i}
		{#if messages[i - 1] && new Date(messages[i].createdAt).getDate() === new Date(messages[i - 1].createdAt).getDate() + 1}
			<ChatDate date={new Date(m.createdAt)} />
		{/if}
		{#if messages[i - 1] && messages[i].authorId === messages[i - 1].authorId && new Date(messages[i].createdAt).getDate() !== new Date(messages[i - 1].createdAt).getDate() + 1}
			<Message {m} showOnlyContent />
		{:else}
			<Message
				{m}
				removeTopPadding={messages[i - 1] &&
					new Date(messages[i].createdAt).getDate() ===
						new Date(messages[i - 1].createdAt).getDate() + 1}
			/>
		{/if}
	{/each}
</div>
