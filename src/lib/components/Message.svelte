<script lang="ts">
	let { m, showOnlyContent = false, removeTopPadding = false }: Tmessage = $props();

	type Tmessage = {
		m: {
			id: string;
			content: string;
			createdAt: Date;
			authorId: string;
			channelId: string;
			authorName: string;
		};
		showOnlyContent?: boolean;
		removeTopPadding?: boolean;
	};

	let formattedCreatedAt = $derived.by(() => {
		let d = new Date(m.createdAt);
		let c = new Date();
		if (c.getDate() === d.getDate()) {
			const f = new Intl.DateTimeFormat('en-US', {
				timeStyle: 'short'
			});
			return `Today at ${f.format(d)}`;
		} else if (c.getDate() - 1 === d.getDate()) {
			const f = new Intl.DateTimeFormat('en-US', {
				timeStyle: 'short'
			});
			return `Yesterday at ${f.format(d)}`;
		}
		const f = new Intl.DateTimeFormat('en-US', {
			timeStyle: 'short',
			dateStyle: 'short'
		});
		return f.format(d).replace(',', ' ');
	});
</script>

<div class="w-full p-4 pb-0" class:pt-0={showOnlyContent || removeTopPadding}>
	{#if showOnlyContent}
		<p>{m.content}</p>
	{:else}
		<div class="font-semibold text-white">
			{m.authorName}
			{#if m.createdAt}
				<span class="ml-1 text-[0.8rem] font-thin leading-snug tracking-wide text-slate-400">
					<time>{formattedCreatedAt}</time>
				</span>
			{/if}
		</div>
		<p>{m.content}</p>
	{/if}
</div>
