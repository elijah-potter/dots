const username = "elijah-potter";
const lookbackDays = 7;
const perPage = 100;
const maxPages = 10;

const formatDay = (date) => date.toISOString().slice(0, 10);

async function main() {
	const today = new Date();
	const since = new Date(today);
	since.setUTCDate(since.getUTCDate() - (lookbackDays - 1));
	const counts = new Map();

	for (let page = 1; page <= maxPages; page += 1) {
		const query = [
			"type:pr",
			`author:${username}`,
			`created:>=${formatDay(since)}`,
			`created:<=${formatDay(today)}`,
		].join(" ");
		const url = `https://api.github.com/search/issues?q=${encodeURIComponent(query)}&per_page=${perPage}&page=${page}&sort=created&order=desc`;
		const response = await fetch(url, {
			headers: { Accept: "application/vnd.github+json" },
		});

		if (!response.ok) {
			throw new Error(`GitHub API error ${response.status}: ${await response.text()}`);
		}

		const body = await response.json();
		for (const item of body.items) {
			if (!item.pull_request) continue;
			const day = item.created_at.slice(0, 10);
			counts.set(day, (counts.get(day) ?? 0) + 1);
		}

		if (body.items.length < perPage) break;
	}

	let total = 0;
	let workDays = 0;
	for (let offset = 0; offset < lookbackDays; offset += 1) {
		const day = new Date(since);
		day.setUTCDate(since.getUTCDate() + offset);
		total += counts.get(formatDay(day)) ?? 0;
		const weekday = day.getUTCDay();
		if (weekday !== 0 && weekday !== 6) workDays += 1;
	}

	console.log(`${(total / workDays).toFixed(2)} PRs/work day`);
}

main().catch((error) => {
	console.error(error.message);
	process.exitCode = 1;
});
