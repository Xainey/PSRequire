function Require
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
    
    [JsonHandler] $handler = [JsonHandler]::new($Path)

    if (!$handler.Exists())
    {
        return "File $Path does not exist. Run Invoke-PSRequire -Init"
    }

    [PSCustomObject] $required = [PSPackage]::GetPackageList($Package)

    foreach($item in $required)
    {
        [PSRepository] $repo = [PSRepository]::new($item.Repository, $item.Module)
        
        if(!$repo.CheckRepo())
        {
            continue
        }

        if(!$repo.CheckModule())
        {
            continue
        }        

        #TODO: Test if version is avaliable

        $key = ("{0}/{1}" -f $item.Repository, $item.Module)
        $member = @{$key = $item.Version}
        $handler.Require($member, $Dev)
    }
}