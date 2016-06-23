function Install
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json",

        [parameter(Mandatory = $False)]
        [string] $Branch = "require"
    )
    
    if (!(Test-Path -Path $Path))
    {
        Write-Host "Missing require.json. Run Invoke-PSRequire -Init."
        return
    }

    $json = Read-JsonFile -Path $Path

    $packagelist = Read-PackageList -Json $json -Node $Branch
    
    Sync-Module -Package $packagelist
}