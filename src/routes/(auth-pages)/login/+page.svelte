<script lang="ts">
	import axios from 'axios';
	import { getCurrentUser } from '$lib/stores/auth.svelte';
	import { redirect } from '@sveltejs/kit';
	import { goto } from '$app/navigation';
	import { pushNotifications } from '$lib/stores/notifications.svelte';

	let showPassword = $state(false);
	let passwordInput = $derived(showPassword ? 'text' : 'password');
	let emailErrors = $state('');
	let emailErrorRing = $derived(emailErrors.length > 0);
	let passwordErrors = $state('');
	let passwordErrorRing = $derived(passwordErrors.length > 0);

	let isLoading = $state(false);

	const handleSubmit = async (e: SubmitEvent) => {
		isLoading = true;
		emailErrors = '';
		passwordErrors = '';
		e.preventDefault();
		const f = new FormData(e.currentTarget as HTMLFormElement);
		const email = f.get('email');
		const password = f.get('password');

		try {
			const res = await axios.post(
				`${import.meta.env.VITE_SERVER_URL}/auth/login`,
				{
					email,
					password
				},
				{
					withCredentials: true
				}
			);
			pushNotifications(res.data.msg);
			getCurrentUser();
			goto('/');
		} catch (err) {
			if (axios.isAxiosError(err)) {
				if (err.response?.data.email) {
					emailErrors = err.response?.data.email[0];
				}
				if (err.response?.data.password) {
					passwordErrors = err.response?.data.password[0];
				}
			}
		}
		isLoading = false;
	};
</script>

<svelte:head>
	<title>Login</title>
</svelte:head>

<form onsubmit={(e) => handleSubmit(e)} class="mx-auto mt-32 flex w-[32rem] flex-col gap-5">
	<div class="grid gap-1">
		<label for="email" class:text-rose-500={emailErrorRing} class="select-none text-sm">Email</label
		>
		<input
			id="email"
			class:err-ring={emailErrorRing}
			onfocusin={() => (emailErrors = '')}
			oninputcapture={() => (emailErrors = '')}
			type="text"
			class="rounded border-none bg-inherit p-2 text-lg outline-none ring-1 ring-slate-400/50 transition-all ease-out hover:ring-fuchsia-500 focus-visible:ring-fuchsia-400"
			name="email"
		/>
		<small class="text-rose-500">{emailErrors}</small>
	</div>

	<div class="relative grid gap-1">
		<div
			class="absolute right-2 top-[35px] cursor-pointer"
			onclick={() => (showPassword = !showPassword)}
			role="button"
			tabindex={-1}
			onkeydown={(e: KeyboardEvent) => {
				if (e.key === ' ') {
					showPassword = !showPassword;
				}
			}}
		>
			{#if !showPassword}
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="size-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z"
					/>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
					/>
				</svg>
			{:else}
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="size-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88"
					/>
				</svg>
			{/if}
		</div>

		<label for="password" class:text-rose-500={passwordErrorRing} class="select-none text-sm"
			>Password</label
		>
		<input
			id="password"
			class:err-ring={passwordErrorRing}
			onfocusin={() => (passwordErrors = '')}
			oninputcapture={() => (passwordErrors = '')}
			type={passwordInput}
			class="rounded border-none bg-inherit p-2 text-lg outline-none ring-1 ring-slate-400/50 transition-all ease-out hover:ring-fuchsia-500 focus-visible:ring-fuchsia-400"
			name="password"
		/>
		<small class="text-rose-500">{passwordErrors}</small>
	</div>
	<button
		class:animate-pulse={isLoading}
		disabled={isLoading}
		class="w-fit select-none rounded border-none bg-fuchsia-500 px-6 py-3 text-sm text-slate-900 outline-none ring-fuchsia-500 ring-offset-slate-900 transition-all ease-out hover:bg-fuchsia-500/90 focus-visible:ring-2 focus-visible:ring-offset-2"
	>
		{#if isLoading}
			<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 animate-spin" viewBox="0 0 24 24"
				><path
					fill="none"
					stroke="currentColor"
					stroke-linecap="round"
					stroke-linejoin="round"
					stroke-width="2"
					d="M12 3a9 9 0 1 0 9 9"
				/></svg
			>
		{:else}
			Submit
		{/if}
	</button>
</form>

<style>
	.err-ring {
		@apply ring-rose-500 hover:ring-rose-600;
	}
</style>
