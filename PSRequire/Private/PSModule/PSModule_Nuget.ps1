class PSModule_Nuget : PSModule 
{

    PSModule_Nuget([String] $Name, [String] $Version)
    {
        $this.Name = $Name
        $this.Version = $Version
    }

    [bool] Exists()
    {
        if(!(Find-Module -Repository $this.Name -Name $this.Module -ErrorAction SilentlyContinue))
        {
            Write-Verbose ("Module '{0}' doesnt exist" -f $this.Module)

            return $false
        }

        return $true
    }

    [bool] VersionExists()
    {
        throw("Must Override Method")
    }

    [void] Install ()
    {
        throw("Must Override Method")
    }

    [void] Uninstall ()
    {
        throw("Must Override Method")
    }

    [void] Update ()
    {
        throw("Must Override Method")
    }

    [PSCustomObject] Get ()
    {
        throw("Must Override Method")
    }

}
