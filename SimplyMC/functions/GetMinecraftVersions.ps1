function GetMineCraftVersions {
    $ErrorActionPreference = "Stop"
    
    $versionList = [CmlLib.Core.CMLauncher]::new([CmlLib.Core.MinecraftPath]::new()).GetAllVersions()
    $versionList = $versionList |
        Where-Object type -in "local","release" | 
        Where-Object {
            try{ [version]$_.Name }
            catch { $false }
        } |
        Sort-Object -Descending -Property @{expression={[version]$_.name}}

    $minVersion = ($versionList | Where-Object IsLocalVersion)[-1].Name
    
    $versionList |
        Where-Object {
            try{ [version]$_.Name -ge [version]$minVersion }
            catch { $false }
        } |
        ForEach-Object Name
}