# https://msdn.microsoft.com/en-us/library/microsoft.powershell.commands.modulespecification(v=vs.85).aspx

# Latest Version
#test-version -version "*"

# Limit Revision
#test-version -version "1.0.*"

# Limit Minor
#test-version -version "1.*"

#Specific Version
#test-version -package "PSGallery/Pester:1.1.1"
function Test-Meta
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [PSCustomObject] $Package
    )

    #split and fill 3-part version
    $versions = $Package.Version.Split('.')

    for($i = $versions.Count; $i -lt 3; $i++)
    {
        #$versions.Add("*")
        $versions += "*"
    }

    $major = $minor = $revis = $null

    [int32]::TryParse($versions[0], [ref]$major ) | Out-Null
    [int32]::TryParse($versions[1], [ref]$minor ) | Out-Null
    [int32]::TryParse($versions[2], [ref]$revis ) | Out-Null

    # Specific: Install specific version
    if (!($versions -match '\*')) 
    {
        return @{
            Repository      = $Package.Repository
            Name            = $Package.Module
            RequiredVersion = New-Object Version -ArgumentList ("{0}.{1}.{2}" -f $major, $minor, $revis)
        }
    }

    # Major *: Install Latest
    if($versions[0] -eq "*")
    {
        return @{
            Repository      = $Package.Repository
            Name            = $Package.Module
        }
    }

    # Minor *
    if($versions[1] -eq "*")
    {
        return @{
            Repository      = $Package.Repository
            Name            = $Package.Module
            MinimumVersion  = "{0}.{1}" -f $major, $minor    
            MaximumVersion  = "{0}.{1}" -f $major, [int32]::maxvalue
        }
    }

    # Revision *
    if($versions[2] -eq "*")
    {
        return @{
            Repository      = $Package.Repository
            Name            = $Package.Module
            MinimumVersion  = "{0}.{1}.{2}" -f $major, $minor, 0
            MaximumVersion  = "{0}.{1}.{2}" -f $major, $minor, [int32]::maxvalue
        }
    }

}
