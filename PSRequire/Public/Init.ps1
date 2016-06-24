function Init
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $False)]
        [string] $Name,

        [parameter(Mandatory = $False)]
        [string] $Description,

        [parameter(Mandatory = $False)]
        [string] $Version,

        [parameter(Mandatory = $False)]
        [string] $Keywords,                        

        [parameter(Mandatory = $False)]
        [string] $Path
    )
    
    if (Test-Path -Path $Path)
    {
        return "File require.json already exists."
    }

    $json = @{ 
        "name"               =  $Name
        "description"        =  $Description
        "version"            =  $Version
        "keywords"           =  $Keywords
        "require"            =  @{"PSGallery/Pester"="*"}
        "require-dev"        =  @{"PSGallery/PSake"="*"}
    }

    $folder = Split-Path -Path $Path
    
    if(!(Test-Path -Path $folder))
    {
        New-Item $folder -Type directory -Force
    }

    $json | ConvertTo-Json | Out-File $Path -Force
}