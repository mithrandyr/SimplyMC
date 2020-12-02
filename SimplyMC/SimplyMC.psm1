if($PSVersionTable.PSEdition -eq "Core") { Add-Type -Path "$PSScriptRoot\lib\netcoreapp3.1\CmlLib.dll" }
else { Add-Type -Path "$PSScriptRoot\lib\net462\CmlLib.dll" }

foreach ($f in Get-ChildItem -Path "$PSScriptRoot\functions" -Filter *.ps1) {
    . $f.FullName
}

$Script:ProfilePath = "$home\AppData\Roaming\.minecraft\SimplyMC-profile.json"