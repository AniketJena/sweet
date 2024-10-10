<script lang="ts">
	import { format } from 'date-fns';

	const { date } = $props();

	let f_date = $derived(format(date as Date, 'MMMM dd, yyyy'));
</script>

<span class="flex items-center w-full text-slate-400 font-semibold text-sm my-2">
	<div class="h-px flex-1 bg-slate-400"> </div>
	  <time class="px-2">
		  {f_date}
	  </time>
	<div class="h-px flex-1 bg-slate-400"> </div>
</span>
