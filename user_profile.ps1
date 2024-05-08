# Prompt theme
# oh-my-posh init pwsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/atomic.omp.json' | Invoke-Expression
$omp_config = Join-Path $PSScriptRoot ".\om.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# Alias
Set-Alias -Name vi  -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name sudo -Value gsudo
Set-Alias -Name neo  -Value fastfetch
Set-Alias ll ls -Force
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias find 'C:\Program Files\Git\usr\bin\find.exe'
Set-Alias unzip 'C:\Program Files\Git\usr\bin\unzip.exe'

#PSReadLine Settings
Set-PSReadLineKeyHandler -Chord "Tab" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord "Ctrl+d" -Function DeleteChar

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

function touch {
	set-content -Path ($args[0]) -Value ($null)
	}

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Check if running as elevated rights (Adminstrator)
function sudo? () {
	[Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544'
	}

# Automatically updates relevant packages
function sysup () {
	Write-Output "`n----------Updating scoop---------------`n"
	scoop update *
	Write-Output "`n---------Updating complete-------------`n"
	}

# Git status shortcut function
function gg () {
	git status
	}

function gh () {
	git pull --all
	}

function getrec {
    param(
        [Parameter(Mandatory=$true)]
        [string]$p,

        [Parameter(Mandatory=$true)]
        [int]$m

    )

    # Get the current date and time
    $currentTime = Get-Date

    # Calculate the date and time x minutes ago
    $targetTime = $currentTime.AddMinutes(-$MinutesAgo)

    # Retrieve files in the specified path modified within the specified time
    Get-ChildItem -Path $Path -File | Where-Object { $_.LastWriteTime -gt $targetTime }
}

function Set-Title {
    param(
        [string]
        $title
    )
    $Host.UI.RawUI.WindowTitle = $title   
}

