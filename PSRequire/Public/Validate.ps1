function Validate
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json"
    )
    
    $json = Read-JsonFile -Path $Path

    if (!(Test-Path -Path $Path))
    {
        Write-Host "Missing require.json. Run Invoke-PSRequire -Init."
        return $false
    }

    $properties = ("version", "name", "description", "require", "require-dev", "keywords")
    foreach($prop in $properties)
    {
        if(!([bool]($json.PSobject.Properties.name -eq $prop)))
        {
            Write-Host "'$prop' missing from require.json"
            return $false
        }
    }

    $require = ($json."require".PSobject.Properties)
    $requireDev = ($json."require-dev".PSobject.Properties)
    foreach($package in $require + $requireDev ) 
    {
        $name =  $package.Name -match '[a-z]/[a-z]'
        $value = $package.Value -match '[0-9.*]'

        if(!($name -and $value))
        {
            Write-Host ("'{0}' : '{1}' bad format in require.json" -f $package.Name, $package.Value)
            return $false
        }
    }
    
    Write-Host "Validation Passed."
    return $true
}