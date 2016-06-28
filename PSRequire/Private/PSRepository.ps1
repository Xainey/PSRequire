class PSRepository
{
    [String] $Name
    [String] $Module
    
    <#
     # Constructor
     #>    
    PSRepository([string]$Name, [string]$Module)
    {
        $this.Name = $Name
        $this.Module = $Module
    }

    <#
     # Save a Module
     #>
    [void] SaveModule()
    {
        Write-Host "PSRepository: Save $($this.Module)"
        #Save-Module -Repository $this.Name -Name $this.Module -Path "." -Force
    }
    
    <#
     # Install a Module
     #>    
    [void] InstallModule()
    {
        Write-Host "PSRepository: Install $($this.Module)"
        #Install-Module @module -Repository $meta.Repository -Force $Force -Scope $Scope -WhatIf
    }

    <#
     # Check if a PSGet Repository Exists
     #>
    [bool] CheckRepo()
    {
        if(!(Get-PSRepository -Name $this.Name -ErrorAction SilentlyContinue))
        {
            Write-Verbose ("Repo '{0}' doesnt exist" -f $this.Name)

            return $false
        }

        return $true
    }

    <#
     # Check if a PSGet Module Exists
     #>
    [bool] CheckModule()
    {
        if(!(Find-Module -Repository $this.Name -Name $this.Module -ErrorAction SilentlyContinue))
        {
            Write-Verbose ("Module '{0}' doesnt exist" -f $this.Module)

            return $false
        }

        return $true
    }

    <#
     # Check if the requested version exists
     #>
    [void] CheckVersion()
    {

    }
    
}