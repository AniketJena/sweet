<script>
	import { goto } from '$app/navigation';
	import { getCurrentUser, user } from '$lib/stores/auth.svelte';
	import { pushNotifications } from '$lib/stores/notifications.svelte';
	import axios from 'axios';

	const handleLogout = async () => {
		try {
			const res = await axios.delete(`${import.meta.env.VITE_SERVER_URL}/auth/logout`, {
				withCredentials: true
			});
			pushNotifications(res.data.msg);
			// console.log(res.data);
			getCurrentUser();
			goto('/');
		} catch (err) {
			if (axios.isAxiosError(err)) {
				// console.log(err.response?.data);
			}
		}
	};
</script>

<header
	class="z-10 col-start-1 col-end-4 row-start-1 row-end-1 flex items-center justify-between border-b-2 border-b-slate-900 bg-black/5 p-5 backdrop-blur"
>
	<div>
		<a href="/" class="sweet group -space-x-1 whitespace-nowrap text-xl">
			<span class="text-amber-500 group-hover:drop-shadow-[0_0_0.5rem_gold]">S</span>
			<span class="text-rose-500 group-hover:drop-shadow-[0_0_0.5rem_hotpink]">W</span>
			<span class="text-emerald-500 group-hover:drop-shadow-[0_0_0.5rem_lightgreen]">E</span>
			<span class="text-fuchsia-500 group-hover:drop-shadow-[0_0_0.5rem_fuchsia]">E</span>
			<span class="text-indigo-500 group-hover:drop-shadow-[0_0_0.5rem_indigo]">T</span>
		</a>
	</div>

	<nav class="grid grid-flow-col-dense items-center gap-4">
		{#if user.name}
			<span>{user.name}</span>
			<button
				onclick={handleLogout}
				class="w-fit select-none rounded-full border-none bg-rose-500 px-4 py-1 text-sm text-slate-900 outline-none ring-rose-500 ring-offset-slate-900 transition-all ease-out hover:bg-rose-500/90 focus-visible:ring-2 focus-visible:ring-offset-2"
				>Logout</button
			>
		{:else}
			<a href="/login">Login</a>
			<a href="/signup">Signup</a>
		{/if}
	</nav>
</header>

<style scoped>
	.sweet {
		@apply font-semibold;
	}
</style>
