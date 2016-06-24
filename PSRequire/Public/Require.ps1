function Require
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $True)]
        [string[]] $Package,

        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json",

        [parameter(Mandatory = $False)]
        [string] $Branch = "require"
    )
    
    if (!(Test-Path -Path $Path))
    {
        Write-Host "Missing require.json. Run Invoke-PSRequire -Init."
        return
    }

    $json = Read-JsonFile -Path $Path

    $required = Read-PackageList -Packages $Package

    foreach($require in $required)
    {

        if(!(Get-PSRepository -Name ($require.Repository) -ErrorAction SilentlyContinue))
        {
            Write-Host ("Repo '{0}' doesnt exist" -f $require.Repository)
            continue
        }

        if(!(Find-Module -Repository $require.Repository -Name $require.Module -ErrorAction SilentlyContinue))
        {
            Write-Host ("Module '{0}' doesnt exist" -f $require.Module)
            continue
        }

        #TODO: Test if version is avaliable

        $key = ("{0}/{1}" -f $require.Repository, $require.Module)

        # Add node to require-* branch. Force to overwrite existing node if specifying the same package.
        $json.$Branch = $json.$Branch | Add-Member @{$key = $require.Version} -PassThru -Force
    }

    $json | ConvertTo-Json | Out-File $Path
}