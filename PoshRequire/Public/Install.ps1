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
        Write-Host "Missing require.json. Run Invoke-PoshRequire -Init."
        return
    }

    $packagelist = Read-PackageList -Path $Path -Node $Branch
    
    Sync-Module -Package $packagelist
}