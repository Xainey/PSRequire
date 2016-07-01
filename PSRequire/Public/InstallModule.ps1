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

    $repoFactory =  [RepositoryFactory]::new()

    # Add Repos to Factory From Json
    foreach ($repo in $json.repository.PSObject.Properties) 
    {
        $name = $repo.Name
        $type = $repo.Value.Type
        $source = $repo.Value.SourceLocation

        $VerbosePreference = "Continue"
        $repoFactory.addRepo($name, $source, $type)
        $VerbosePreference = "SilentlyContinue"
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

    "`nTesting Repo Methods"
    foreach($repo in $repoFactory.Repositories)
    {
        "Name: {0} Exists: {1}" -f $repo.Name, $repo.Exists()
    }

    "`nRequired List"
    foreach ($required in $json.require.PSObject.Properties) 
    {
        "Name: {0} Value: {1}" -f $required.Name, $required.Value
    }

    "`nTesting Reference"
    #$repoFactory.Repositories.Where({$_ -is [Repository_Git]})
    #$repoFactory.Repositories.Where({$_.Name -eq "PSGallery"})
    #$repoFactory.getByName("PSGallery")
    $repoFactory.getByType([Repository_Nuget]).Name

}