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

    $json = $handler.Read()

    [PSRepositoryFactory] $repoFactory = [PSRepositoryFactory]::new()

    # Add Repos to Factory From Json
    foreach ($repo in $json.repository.PSObject.Properties) 
    {
        $name = $repo.Name
        $type = $repo.Value.Type
        $source = $repo.Value.SourceLocation

        #$VerbosePreference = "Continue"
        $repoFactory.addRepo($name, $source, $type)
        #$VerbosePreference = "SilentlyContinue"
    }

    #Add Existing Repos
    $existingRepo = (Get-PSRepository)
    foreach($repo in $existingRepo)
    {
        $name = $repo.Name
        $type = $repo.PackageManagementProvider
        $source = $repo.SourceLocation

        $VerbosePreference = "Continue"
        $repoFactory.addRepo($name, $source, $type)
        $VerbosePreference = "SilentlyContinue"
    }

    <#
    "`nTesting Repo Methods"
    foreach($repo in $repoFactory.Repositories)
    {
        "Name: {0} Exists: {1}" -f $repo.Name, $repo.Exists()
    }
   
    
    "-" * 80 + "`nRequired List"
    foreach ($required in $json.require.Modules.PSObject.Properties) 
    {
        "Name: {0} Value: {1}" -f $required.Name, $required.Value
    }


    "`nRequired Dev List"
    $branch = "require-dev"
    foreach ($required in $json.$branch.PSObject.Properties) 
    {
        "Name: {0} Value: {1}" -f $required.Name, $required.Value
    }
    "-" * 80
    #>

    $requiredModules = [PSPackage]::GetPackageList($json.require, "Modules")
    foreach($mod in $requiredModules)
    {
        $repoFactory.addModule($mod.Repository, $mod.Module, $mod.Version)
    }
    
    $repoFactory.getByName("PSGallery").ModuleFactory

    foreach ($module in $repoFactory.getByName("PSGallery").ModuleFactory.Modules)
    {
        $module.Name
    }

    <#
    "`nTesting Reference"
    #$repoFactory.Repositories.Where({$_ -is [Repository_Git]})
    #$repoFactory.Repositories.Where({$_.Name -eq "PSGallery"})
    #$repoFactory.getByName("PSGallery")
    $repoFactory.getByType([PSRepository_Nuget]).Name
    #>

    <#
    # Maybe use helper function
    $repoFactory.addModule("PSGallery", "Psake", "4.0.0")
    $repoFactory.addModule("PSGallery", "Pester", "3.0.0")

    $PSGallery = $repoFactory.getByName("PSGallery")
    #$PSGallery.ModuleFactory.addModule("Psake", [Version] "4.0.0" , "NuGeT")
    $PSGallery.ModuleFactory.getByName("Psake")
    #>
}