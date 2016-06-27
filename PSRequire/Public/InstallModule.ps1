function InstallModule
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json",

        [parameter(Mandatory = $False)]
        [string] $Branch = "require",

        [Parameter(Mandatory=$False)]
        [bool] $Save = $false
    )
    
    if (!(Test-Path -Path $Path))
    {
        Write-Host $Path
        Write-Host "Missing require.json. Run Invoke-PSRequire -Init."
        return
    }

    $json = Read-JsonFile -Path $Path

    $packagelist = Read-PackageList -Json $json -Node $Branch
    
    
    foreach ($module in $packagelist)
    {
        Write-Verbose "Testing module: '$module'..."

        [PSRepository] $repo = [PSRepository]::new($module.Repository, $module.Module)
        $repo.CheckRepo()
        $repo.CheckModule()

    }

}