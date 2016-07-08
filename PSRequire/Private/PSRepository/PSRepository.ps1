class PSRepository
{
    [String] $Name
    [String] $SourceLocation
    [PSModuleFactory] $ModuleFactory

    <#
     # Constructor
     #>    
    Repository()
    {
        $type = $this.GetType()

        if ($type -eq [PSRepository])
        {
            throw("Class $type must be inherited")
        }
    }

    [bool] Exists()
    {
        throw("Must Override Method")
    }

    [void] Register ()
    {
        throw("Must Override Method")
    }

    [void] Set ()
    {
        throw("Must Override Method")
    }

    [void] Unregister ()
    {
        throw("Must Override Method")
    }

    [PSCustomObject] Get ()
    {
        throw("Must Override Method")
    }

    <#
     # Helper for Splatting PS Functions
     #>
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