function Start-MineCraft {
    [cmdletBinding(DefaultParameterSetName="default")]
    param([string]$Name, [string]$Version, [switch]$Persist)
    $ErrorActionPreference = "Stop"

    $profile = LoadProfile

    if(-not $Name) {
        if(-not $profile.Name) {
            while(-not $Name) { $Name = Read-Host "Please enter your name (pay attention to capitalization!)" }
            $profile.Name = $Name
            SaveProfile -Profile $profile
        }
        else {
            $Name = $profile.Name
            Write-Host "Using '$Name' from profile."
            Write-Host
        }
    }
    elseif($Persist) {
        $profile.Name = $Name
        SaveProfile -Profile $profile
    }
    
    if(-not $Version) {
        if(-not $profile.Version) {
            $versionList = GetMinecraftVersions
            while(-not $Version -or $version -notin $versionList) {
                Write-Host ("Available Versions: {0}" -f ($versionList -join ", "))
                $Version = Read-Host "Please enter the version you want to play"
            }
            $profile.Version = $Version
            SaveProfile -Profile $profile
        }
        else {
            $Version = $profile.Version
            Write-Host "Using '$Version' from profile."
            Write-Host
        }
    }
    elseif($Persist) {
        $profile.Version = $Version
        SaveProfile -Profile $profile
    }

    #launch minecraft
    $session = [CmlLib.Core.Auth.MSession]::GetOfflineSession($Name)
    $launcher = [CmlLib.Core.CMLauncher]::new([CmlLib.Core.MinecraftPath]::new())
    $launchOption = [CmlLib.Core.MLaunchOption]@{Session = $session}
    $launcher.CreateProcess("1.16.3", $launchOption).Start() | Out-Null
    
    Write-Host "MineCraft may take a few seconds to launch, please be patient..."
    Write-Host
    (1..16) | ForEach-Object { Start-Sleep -Milliseconds 500; Write-Host "." -NoNewline }
}

Register-ArgumentCompleter -CommandName Start-MineCraft -ParameterName Version -ScriptBlock { GetMinecraftVersions }
