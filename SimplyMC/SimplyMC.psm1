if($PSVersionTable.PSEdition -eq "Core") { Add-Type -Path "$PSScriptRoot\bin\core\CmlLib.dll" }
else { Add-Type -Path "$PSScriptRoot\bin\winps\CmlLib.dll" }

foreach ($f in Get-ChildItem -Path "$PSScriptRoot\functions" -Filter *.ps1) {
    . $f.FullName
}

$Script:ProfilePath = "$home\AppData\Roaming\.minecraft\SimplyMC-profile.json"