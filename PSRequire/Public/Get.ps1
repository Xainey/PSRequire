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
        return "Missing require.json. Run Invoke-PSRequire -Init."
    }

    return $json
}