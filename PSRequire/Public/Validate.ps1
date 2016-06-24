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

    $r = ($json."require".PSobject.Properties)
    $requireDev = ($json."require-dev".PSobject.Properties)

    Write-Verbose ( $r | Out-String )
    Write-Verbose ( $requireDev | Out-String )

    foreach($p in ($r + $requireDev) ) 
    {
        $name =  $p.Name -match '[a-z]/[a-z]'
        $value = $p.Value -match '[0-9.*]'

        if(!($name -and $value))
        {
            Write-Host ("'{0}' : '{1}' bad format in require.json" -f $p.Name, $p.Value)
            return $false
        }
    }
    
    return $true
}