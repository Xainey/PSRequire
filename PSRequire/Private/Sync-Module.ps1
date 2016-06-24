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
        [PSCustomObject] $Package,

        [Parameter(Mandatory=$false)]
        [string] $Force = $false,

        [Parameter(Mandatory=$false)]
        [string] $Scope = 'AllUsers',

        [Parameter(Mandatory=$False)]
        [bool] $Save = $false       
    )

    foreach ($module in $Package)
    {
        Write-Verbose "Testing module: '$module'..."

        $meta = (test-meta -package $module)
        $repository = $meta.Clone()
        $repository.Remove("Repository")

        if($meta.RequiredVersion)
        {
            Write-Verbose "Specific version required."           
        }
        elseif($meta.MaximumVersion -and $meta.MinimumVersion)
        {
            Write-Verbose "Max/min required."
        }
        else
        {
            Write-Verbose "Install latest."
        }
        
        if($Save)
        {
            if($module.Version -eq "*")
            {
                $module.PSObject.Properties.Remove('Version')
            }

            Save-Module -Repository $meta.Repository -Name $meta.Name -Path "." -Force
            return
        }

        if(!(Get-InstalledModule @repository -ErrorAction SilentlyContinue))
        {
            Write-Verbose "Correct Version not Installed. Installing."
            Install-Module @module -Repository $meta.Repository -Force $Force -Scope $Scope -WhatIf
        }
        else
        {
            Write-Verbose "Module already Installed"
        }
    }
}