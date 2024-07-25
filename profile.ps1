Import-Module PSReadLine

Set-PSReadlineOption -EditMode vi

Set-Alias -Name n -Value 'nvim'
Set-Alias -Name g -Value './gradlew.bat'
Set-Alias -Name lg -Value 'lazygit'

function oe {
  cd C:\TylerDev\github\eagle
}

function gs {
  git stash
  git pull --rebase
  git push
  git stash pop
}

# For light mode
Set-PSReadLineOption -Colors @{
  Command            = 'Black'
  Number             = 'DarkGray'
  Member             = 'DarkGray'
  Operator           = 'DarkGray'
  Type               = 'DarkGray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = 'DarkGray'
  Default            = 'DarkGray'
}
 
# Logging / Progress colors
 
$p = $host.privatedata
$p.ErrorForegroundColor    = "Red"
$p.ErrorBackgroundColor    = "White"
$p.WarningForegroundColor  = "Yellow"
$p.WarningBackgroundColor  = "White"
$p.DebugForegroundColor    = "Yellow"
$p.DebugBackgroundColor    = "White"
$p.VerboseForegroundColor  = "Black"
$p.VerboseBackgroundColor  = "White"
$p.ProgressForegroundColor = "DarkGray"
$p.ProgressBackgroundColor = "White"

Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function AcceptSuggestion 
