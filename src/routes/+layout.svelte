<script>
	import '../app.css';
	import { user, getCurrentUser } from '../stores/auth.svelte';

	let { children } = $props();

	$effect(() => {
		getCurrentUser();
	});
</script>

{@render children()}

<style></style>
