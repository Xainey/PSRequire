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
        [string] $package
    )

    $input   = $package.Split(":")
    $meta    = $input[0].Split("/")
    $version = $input[1]
    $repo    = $meta[0]
    $module  = $meta[1]

    Write-Verbose "Repo: $repo; Module: $module; Version: $version"

    #split and fill 3-part version
    $versions = {$version.Split('.')}.Invoke()

    for($i=$versions.Count; $i -lt 3; $i++)
    {
        $versions.Add("*")
    }

    $major = $minor = $revis = $null

    [int32]::TryParse($versions[0], [ref]$major ) | Out-Null
    [int32]::TryParse($versions[1], [ref]$minor ) | Out-Null
    [int32]::TryParse($versions[2], [ref]$revis ) | Out-Null

    #Specific: Install specific version
    if (!($versions -match '\*')) 
    {
        Write-Verbose "Specific Version"
        return @{
            Repository      = $repo
            Name            = $module
            RequiredVersion = New-Object Version -ArgumentList ("{0}.{1}.{2}" -f $major, $minor, $revis)
        }
    }

    #major: Install Latest
    if($versions[0] -eq "*")
    {
        Write-Verbose "Major *"
        return @{
            Repository      = $repo
            Name            = $module
        }
    }

    #minor
    if($versions[1] -eq "*")
    {
        Write-Verbose "Minor *"
        return @{
            Repository      = $repo
            Name            = $module
            MinimumVersion = "{0}.{1}" -f $major, $minor    
            MaximumVersion = "{0}.{1}" -f $major, [int32]::maxvalue
        }
    }

    #revis
    if($versions[2] -eq "*")
    {
        Write-Verbose "Revision *"
        return @{
            Repository      = $repo
            Name            = $module
            MinimumVersion = "{0}.{1}.{2}" -f $major, $minor, 0
            MaximumVersion = "{0}.{1}.{2}" -f $major, $minor, [int32]::maxvalue
        }
    }
}
