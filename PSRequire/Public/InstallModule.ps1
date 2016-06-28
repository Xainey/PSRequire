# Test class for refactoring Install.ps1

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
    
    [JsonHandler] $handler = [JsonHandler]::new($Path)

    if (!$handler.Exists())
    {
        return "File $Path does not exist"
    }

    $packageList = Read-PackageList -Json $handler.Read() -Node $Branch

    foreach ($module in $packageList)
    {
        [PSRepository] $repo = [PSRepository]::new($module.Repository, $module.Module)
        $repo.CheckRepo()
        $repo.CheckModule()

        $meta = (test-meta -package $module)
        Write-Host ( $meta | Out-String )
    }

}