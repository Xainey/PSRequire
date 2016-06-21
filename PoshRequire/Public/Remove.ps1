function Remove
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $True)]
        [string[]] $Package,

        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json",

        [parameter(Mandatory = $False)]
        [string] $Branch = "require"

    )
    
    $json = Read-JsonFile -Path $Path

    if (!(Test-Path -Path $Path))
    {
        Write-Host "Missing require.json. Run Invoke-PoshRequire -Init."
        return
    }

    foreach($module in $Package)
    {
        $json.$Branch.PSObject.Properties.Remove($module)
    }

    $json | ConvertTo-Json | Out-File $Path
}