class PSModule
{
    [String] $Name
    [String] $Version

    PSModule()
    {
        $type = $this.GetType()

        if ($type -eq [PSModule])
        {
            throw("Class $type must be inherited")
        }
    }


    [bool] Exists()
    {
        throw("Must Override Method")
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


    [HashTable] Splat([String[]] $Properties)
    {
        $splat = @{}

        foreach($prop in $Properties)
        {
            if($this.GetType().GetProperty($prop))
            {
                $splat.Add($prop, $this.$prop)
            }
        }

        return $splat
    }
}