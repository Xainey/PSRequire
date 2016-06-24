function Require
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $True)]
        [string[]] $Package,

        [parameter(Mandatory = $False)]
        [string] $Path = "$(Get-Location)\require.json",

        [parameter(Mandatory = $False)]
        [switch] $Dev
    )
    
    if (!(Test-Path -Path $Path))
    {
        Write-Host "Missing require.json. Run Invoke-PSRequire -Init."
        return
    }

    if($Dev)
    {
        $Branch = "require-dev"
    }
    else
    {
        $Branch = "require"
    }

    $json = (Read-JsonFile -Path $Path)

    $required = (Read-PackageList -Packages $Package)

    foreach($item in $required)
    {

        if(!(Get-PSRepository -Name ($item.Repository) -ErrorAction SilentlyContinue))
        {
            Write-Host ("Repo '{0}' doesnt exist" -f $item.Repository)
            continue
        }

        if(!(Find-Module -Repository $item.Repository -Name $item.Module -ErrorAction SilentlyContinue))
        {
            Write-Host ("Module '{0}' doesnt exist" -f $item.Module)
            continue
        }

        #TODO: Test if version is avaliable

        $key = ("{0}/{1}" -f $item.Repository, $item.Module)

        # Add node to require-* branch. Force to overwrite existing node if specifying the same package.
        $json.$Branch = $json.$Branch | Add-Member @{$key = $item.Version} -PassThru -Force
    }

    $json | ConvertTo-Json | Out-File $Path
}