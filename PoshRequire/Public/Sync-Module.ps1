<#
Work in Progress
Sync-Modules -Package ("PSGallery/Pester:3.4.*", "PSGallery/PSake:*") -Scope CurrentUser -Force
Module version for Pester must be in the rage: <= 3.4.0 and > 3.5
Module version for PSake: latest
#>
function Sync-Module
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string[]] $Package,

        [Parameter(Mandatory=$false)]
        [string] $Force = $false,

        [Parameter(Mandatory=$false)]
        [string] $Scope = 'All Users'
    )

    foreach ($module in $Package)
    {
        $meta = (test-meta -package $module)
        $repository = ($meta.Clone())
        $repository.Remove("Repository")
        
        $meta

        if($meta.RequiredVersion)
        {
            Write-Verbose "specific version required"           
        }
        elseif($meta.MaximumVersion -and $meta.MinimumVersion)
        {
            Write-Verbose "max/min required"
        }
        else
        {
            Write-Verbose "Install latest"
        }
        
        if(!(Get-InstalledModule @repository -ErrorAction SilentlyContinue))
        {
            Write-Verbose "Correct Version not Installed"
            #Install-Module @module -Repository $meta.Repository -Force $Force
        }
        else
        {
            Write-Verbose "Module Installed"
        }
        
    }
}