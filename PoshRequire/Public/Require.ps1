function Require
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
        $pieces = $module.split(":")

        if($pieces.Count -ne 2)
        {
            Write-Host "Invalid Package Syntax"
            return
        }

        #TODO: Verify Package Exists

        $json.$Branch = $json.$Branch | Add-Member @{$pieces[0] = $pieces[1]} -PassThru
    }

    $json | ConvertTo-Json | Out-File $Path
}