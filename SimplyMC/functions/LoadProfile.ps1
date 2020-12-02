function LoadProfile {
    if(Test-Path $Script:ProfilePath) { Get-Content $Script:ProfilePath | ConvertFrom-Json }
    else {
        [PSCustomObject]@{
            Name = ""
            Version = ""
        }
    }
}