function pido --description 'Create a pi workspace with an arbitrary prompt'
  if test (count $argv) -lt 2
    echo "Usage: pido <workspace> <prompt...>" >&2
    return 2
  end

  set -l workspace $argv[1]
  set -e argv[1]
  set -l prompt (string join ' ' -- $argv)

  ad add --agent pi --prompt "$prompt" $workspace
  or return $status
end
