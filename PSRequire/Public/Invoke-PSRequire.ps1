function Invoke-PSRequire
{
    [cmdletbinding(DefaultParameterSetName="Help")]
    param( 
        #Help
        [Parameter(Mandatory=$False, ParameterSetName="Help")]
        [switch] $Help,

        # Require
        [Parameter(Mandatory=$True, ParameterSetName="Require")]
        [switch] $Require,
        
        # Init      
        [Parameter(Mandatory=$True, ParameterSetName="Init")]
        [switch] $Init,
        [String] $Name,
        [String] $Description,
        [String] $Version,
        [String] $Keywords,

        # Remove      
        [Parameter(Mandatory=$True, ParameterSetName="Remove")]
        [switch] $Remove,

        # Install      
        [Parameter(Mandatory=$True, ParameterSetName="Install")]
        [switch] $Install,     
        [bool] $Save = $false,

        # Update      
        [Parameter(Mandatory=$True, ParameterSetName="Update")]
        [switch] $Update,

        # Get      
        [Parameter(Mandatory=$True, ParameterSetName="Get")]
        [switch] $Get,

        # Validate      
        [Parameter(Mandatory=$True, ParameterSetName="Validate")]
        [switch] $Validate,

        # Shared
        [Parameter(Mandatory=$True, ParameterSetName="Require", Position=0)]
        [Parameter(Mandatory=$True, ParameterSetName="Remove", Position=0)]
        [String[]] $Package,

        [Parameter(Mandatory=$False, ParameterSetName="Require", Position=2)]
        [Parameter(Mandatory=$False, ParameterSetName="Remove", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Install", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Update", Position=1)]
        [switch] $Dev,

        [Parameter(Mandatory=$False, ParameterSetName="Require", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Init", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Validate", Position=0)]
        [Parameter(Mandatory=$False, ParameterSetName="Get", Position=0)]
        [String] $Path = "$(Get-Location)\require.json"
    )
    
    Write-Verbose "Triggering $($PsCmdlet.ParameterSetName)"

    # Remove Switch for ParmameterSetName
    $PSBoundParameters.Remove($PsCmdlet.ParameterSetName)

    Write-Verbose "PSBoundParameters $($PSBoundParameters | Out-String)"

    # Call Functon with Bound Parms
    . $PsCmdlet.ParameterSetName @PSBoundParameters
}