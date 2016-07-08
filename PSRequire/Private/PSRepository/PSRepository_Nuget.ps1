class PSRepository_Nuget : PSRepository
{
    [String] $Name
    [String] $PackageManagementProvider
    [String] $InstallationPolicy
    [String] $SourceLocation
        
    <#
     # Constructor
     #>    
    PSRepository_Nuget([String]$Name, [String] $SourceLocation)
    {
        $this.Name = $Name
        $this.PackageManagementProvider = "NuGet"
        $this.InstallationPolicy = "Trusted"
        $this.SourceLocation = $SourceLocation
        $this.ModuleFactory = [PSModuleFactory]::new() 
    }

    <#
     # Check if Repository Exists
     # May want to check [SourceLocation] are properly set as well
     #>
    [bool] Exists()
    {
        if(!(Get-PSRepository -Name $this.Name -ErrorAction SilentlyContinue))
        {
            return $false
        }

        return $true
    }

    <#
     # Register a PS Repository
     #>    
    [void] Register ()
    {
        if(!$this.Exists())
        {
            $parms = $this.Splat(("Name", "SourceLocation", "InstallationPolicy"))
            Register-PSRepository @parms
        }
    }

    <#
     # Alter a PS Repository
     #>    
    [void] Set ()
    {
        if($this.Exists())
        {
            $parms = $this.Splat(("Name", "SourceLocation", "InstallationPolicy"))
            Set-PSRepository @parms
        }
    }

    <#
     # Unregister a PS Repository
     #>    
    [void] Unregister ()
    {
        if($this.Exists())
        {
            Unregister-PSRepository -Name $this.Name
        }
    }

    <#
     # Get a PS Repository
     #>    
    [PSCustomObject] Get ()
    {
        return Get-PSRepository -Name $this.Name
    }

}