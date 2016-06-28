function Init
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $False)]
        [string] $Name  = "Required Modules/Dependencies",

        [parameter(Mandatory = $False)]
        [string] $Description = "Imported ",

        [parameter(Mandatory = $False)]
        [string] $Version = "1.0.0",

        [parameter(Mandatory = $False)]
        [string] $Keywords = "{}",

        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json"
    )
    
    [JsonHandler] $handler = [JsonHandler]::new($Path)

    if ($handler.Exists())
    {
        return "File $Path already exists"
    }

    $json = @{ 
        "name"               =  $Name
        "description"        =  $Description
        "version"            =  $Version
        "keywords"           =  $Keywords
        "require"            =  @{"PSGallery/Pester"="*"}
        "require-dev"        =  @{"PSGallery/PSake"="*"}
        "repository"         =  @{
                                    "Xainey"	= @{Type = "Git"; URL = "http:\\google.com"}
                                    "MyRepo"	= @{Type = "PSGET"; URL = "http:\\google.com"}
                                }
    }

    $handler.Init($json)
}