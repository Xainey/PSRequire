function Read-JsonFile
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $True)]
        [string] $Path
    )

    $extension = [System.IO.Path]::GetExtension($Path)

    if($extension -ne ".json")
    {
        throw("File must be a .json file.")
    }

    try
    {
        return Get-Content -Raw -Path $Path | ConvertFrom-Json
    } 
    catch 
    {
        return "Error converting contents to JSON."
    }

}