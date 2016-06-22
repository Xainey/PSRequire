function Get
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json"
    )
    
    $json = Read-JsonFile -Path $Path

    if (!(Test-Path -Path $Path))
    {
        Write-Host "Missing require.json. Run Invoke-PSRequire -Init."
        return
    }

    return $json
}