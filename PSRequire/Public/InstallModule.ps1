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

<#
    [PSCustomObject] $packageList = [PSPackage]::GetPackageList($handler.Read(), $Branch)

    foreach ($module in $packageList)
    {
        [PSRepository] $repo = [PSRepository]::new($module.Repository, $module.Module)
        $repo.CheckRepo()
        $repo.CheckModule()

        $meta = (test-meta -package $module)
        Write-Host ( $meta | Out-String )
    }
#>

    $json = $handler.Read()

    foreach ($repo in ($json.repository | Get-Member * -MemberType NoteProperty).Name) 
    {
        $name = $repo
        $type = $json.repository.$repo.Type
        $source = $json.repository.$repo.SourceLocation

        [RepositoryFactory]::addRepo($name, $source, $type)
    }

    foreach($repo in [RepositoryFactory]::Repositories)
    {
        $repo.GetType()
    }

}