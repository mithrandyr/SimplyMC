function SaveProfile {
    Param($profile)
    $profile |
        ConvertTo-Json |
        Set-Content -Path $Script:ProfilePath -Force
}