class PSRepository
{
    [String] $Name
    [String] $Module
    
    PSRepository([string]$Name, [string]$Module)
    {
        $this.Name = $Name
        $this.Module = $Module
    }
            
    [void] SaveModule()
    {
        Write-Host "PSRepository: Save $($this.Module)"
        #Save-Module -Repository $this.Name -Name $this.Module -Path "." -Force
    }
    
    [void] InstallModule()
    {
        Write-Host "PSRepository: Install $($this.Module)"
        #Install-Module @module -Repository $meta.Repository -Force $Force -Scope $Scope -WhatIf
    }

    [bool] CheckRepo()
    {
        if(!(Get-PSRepository -Name $this.Name -ErrorAction SilentlyContinue))
        {
            Write-Verbose ("Repo '{0}' doesnt exist" -f $this.Name)

            return $false
        }

        return $true
    }

    [bool] CheckModule()
    {
        if(!(Find-Module -Repository $this.Name -Name $this.Module -ErrorAction SilentlyContinue))
        {
            Write-Verbose ("Module '{0}' doesnt exist" -f $this.Module)

            return $false
        }

        return $true
    }

    [void] CheckVersion()
    {

    }

}