<script lang="ts">
	import type { Snippet } from 'svelte';
	import { fly, type FlyParams } from 'svelte/transition';

	const slideIn: FlyParams = {
		x: -40
	};
	const slideOut: FlyParams = {
		x: 40
	};
	let { children } = $props<{ children: Snippet<[]> }>();
	//animation: animated-ring 3s ease linear;
</script>

<div class="rounded" in:fly={slideIn} out:fly={slideOut}>
	<div class="min-w-28 rounded bg-slate-800 p-4">
		{@render children()}
	</div>
</div>

