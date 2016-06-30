using namespace Repository

class Repository_Git : Repository
{
    [String] $Name
    [String] $SourceLocation
    
    <#
     # Constructor
     #>    
    Repository_Git([String]$Name, [String] $SourceLocation)
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
     # Check if a PSGet Repository Exists
     #>
    [bool] Exists()
    {
        try
        {
           & git $this.SourceLocation | Out-Null
        }
        catch 
        {
            return $false
        }

        return $true
    }

    [void] Register ()
    {

    }

    [void] Set ()
    {
        
    }

    [void] Unregister ()
    {
        
    }

    [PSCustomObject] Get ()
    {
        $parms = $this.Splat(("Name", "SourceLocation"))

        return $parms
    }

}