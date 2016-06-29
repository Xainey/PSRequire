function Install
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

    [PSCustomObject] $packageList = [PSPackage]::GetPackageList($handler.Read(), $Branch)
    
    Sync-Module -Package $packagelist -Save $Save
}