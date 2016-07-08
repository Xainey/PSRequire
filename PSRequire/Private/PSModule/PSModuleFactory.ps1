class PSModuleFactory
{
    [PSModule[]] $Modules

    <#
     # Constructor
     #>    
    PSModuleFactory()
    {
    }    

    <#
     # Add an Repository base object to $Modules
     #>    
    [void] addModule ([String] $Name, [String] $Version, [String] $Type)
    {
        [PSModule] $module = (New-Object -TypeName "PSModule_$Type" -ArgumentList $Name, $Version)

        $this.Modules += $module
    }

    <#
     # get objects from $Modules by Name
     #>    
    [Object] getByName([String] $Name)
    {
        return $this.Modules.Where({$_.Name -eq $Name})
    }

    <#
     # Get objects from $Modules by Type
     #>    
    [Object] getByType([Object] $Object)
    {
        return $this.Modules.Where({$_ -is $Object})
    }    

}