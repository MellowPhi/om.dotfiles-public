# Prompt theme
$omp_config = Join-Path $PSScriptRoot ".\om.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# Alias
Set-Alias -Name vi  -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name sudo -Value gsudo
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

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
	Write-Output "----------Updating chocolatey----------"
	sudo choco upgrade chocolatey
	Write-Output "----------Updating scoop---------------"
	scoop update *
	Write-Output "---------Updating complete-------------"
	}
