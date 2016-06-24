function Remove
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $True)]
        [string[]] $Package,

        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json",

        [parameter(Mandatory = $False)]
        [switch] $Dev

    )
        
    $json = Read-JsonFile -Path $Path

    if (!(Test-Path -Path $Path))
    {
        Write-Host "Missing require.json. Run Invoke-PSRequire -Init."
        return
    }

    if($Dev)
    {
        $Branch = "require-dev"
    }
    else
    {
        $Branch = "require"
    }

    foreach($module in $Package)
    {
        $json.$Branch.PSObject.Properties.Remove($module)
    }

    $json | ConvertTo-Json | Out-File $Path
}