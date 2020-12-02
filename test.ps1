Add-Type -Path "$PSScriptRoot\SimplyMC\bin\winps\CmlLib.dll"

$session = [CmlLib.Core.Auth.MSession]::GetOfflineSession("Daddy")

$launcher = [CmlLib.Core.CMLauncher]::new([CmlLib.Core.MinecraftPath]::new())

$launchOption = [CmlLib.Core.MLaunchOption]@{Session = $session}

#$launcher.GetAllVersions()

$process = $launcher.CreateProcess("1.16.3", $launchOption)

$process.Start() | Out-Null
$process