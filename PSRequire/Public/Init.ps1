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

    [Hashtable] $json = @{ 
        "name"               =  $Name
        "description"        =  $Description
        "version"            =  $Version
        "keywords"           =  $Keywords
        "require"            =  @{"PSGallery/Pester"="*"}
        "require-dev"        =  @{"PSGallery/PSake"="*"}
        "repository"         =  @{
                                    "PSGallery"	= @{Type = "NuGeT"; SourceLocation = "https://www.powershellgallery.com/api/v2/"}
                                    "Github"	= @{Type = "Git"; SourceLocation = "https://github.com/Xainey/PSRequire.git"}
                                }
    }

    $handler.Init($json)
}