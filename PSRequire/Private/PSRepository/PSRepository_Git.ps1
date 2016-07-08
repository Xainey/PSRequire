class PSRepository_Git : PSRepository
{
    [String] $Name
    [String] $SourceLocation
    
    <#
     # Constructor
     #>
    PSRepository_Git([String]$Name, [String] $SourceLocation)
    {
        try
        {
            & git | Out-Null
        }
        catch 
        {
            throw ("Git must be installed")
        }

        $this.Name = $Name
        $this.SourceLocation = $SourceLocation
    }

    <#
     # Check if a Git Repository Exists
     #>
    [bool] Exists()
    {
        try
        {
           & git ls-remote $this.SourceLocation | Out-Null
        }
        catch 
        {
            return $false
        }

        return $true
    }

    <#
     #
     #>
    [void] Register ()
    {

    }

    <#
     #
     #>
    [void] Set ()
    {
        
    }

    <#
     # Constructor
     #>
    [void] Unregister ()
    {
        
    }

    <#
     # Constructor
     #>
    [PSCustomObject] Get ()
    {
        $parms = $this.Splat(("Name", "SourceLocation"))

        return $parms
    }

}