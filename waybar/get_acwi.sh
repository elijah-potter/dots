#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C
h1='-H' ; ua='User-Agent: Mozilla/5.0' ; acc='Accept: application/json' ; ref='Referer: https://finance.yahoo.com/'
urls=(
  'https://query2.finance.yahoo.com/v8/finance/chart/ACWI?range=1d&interval=1m'
  'https://query1.finance.yahoo.com/v8/finance/chart/ACWI?range=1d&interval=1m'
  'https://r.jina.ai/http://query2.finance.yahoo.com/v8/finance/chart/ACWI?range=1d&interval=1m'
  'https://r.jina.ai/http://query1.finance.yahoo.com/v8/finance/chart/ACWI?range=1d&interval=1m'
)
pct=""
for u in "${urls[@]}"; do
  j=$(curl --fail --compressed -sSL $h1 "$ua" $h1 "$acc" $h1 "$ref" "$u") || continue
  p=$(jq -er '.chart.result[0] as $r | ($r.meta.previousClose // $r.meta.chartPreviousClose) as $prev | ($r.indicators.quote[0].close | map(select(.!=null)) | last) as $last | if ($prev!=null and $prev>0 and $last!=null) then (($last-$prev)/$prev*100) else empty end' <<<"$j") || true
  if [ -n "${p:-}" ]; then pct="$p"; break; fi
done
if [ -z "${pct:-}" ]; then
  csv=$(curl -sS --fail --compressed 'https://stooq.com/q/d/l/?s=acwi.us&i=d')
  pct=$(printf '%s\n' "$csv" | awk -F',' 'NR>1{p=l;l=$5}END{gsub(/\r/,"",p);gsub(/\r/,"",l);if(p==""||l==""||p=="N/D"||l=="N/D"||p+0==0) exit 1; printf("%.2f",((l-p)/p*100))}')
fi
printf '%.2f%%\n' "$pct"
