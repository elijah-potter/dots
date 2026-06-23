function merge-pr-conflict --argument-names pr_number --description 'Create a PR merge-conflict workspace and start pi'
  if test (count $argv) -ne 1
    echo "Usage: merge-pr-conflict <PR NUMBER>" >&2
    return 2
  end

  if not string match -rq '^[0-9]+$' -- $pr_number
    echo "merge-pr-conflict: PR number must be numeric" >&2
    return 2
  end

  set -l workspace "merge-$pr_number"

  pido $workspace "/fix-pr-conflict $pr_number"
  or return $status
end
