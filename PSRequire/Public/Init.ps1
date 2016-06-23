function Init
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $False)]
        [string] $Name,

        [parameter(Mandatory = $False)]
        [string] $Path
    )
    
    if (Test-Path -Path $Path)
    {
        return "File require.json already exists."
    }

    $json = @{ 
        "name"               =  $Name
        "description"        =  ""
        "version"            =  "1.0.0"
        "keywords"           =  "{Keywords}"
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