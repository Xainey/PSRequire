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
    
    if ($null -ne (Get -Path $Path))
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