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
        [String] $Name = "Required Modules/Dependencies",

        # Remove      
        [Parameter(Mandatory=$True, ParameterSetName="Remove")]
        [switch] $Remove,

        # Install      
        [Parameter(Mandatory=$True, ParameterSetName="Install")]
        [switch] $Install,

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
        [Parameter(Mandatory=$True, ParameterSetName="RequireDev", Position=0)]
        [Parameter(Mandatory=$True, ParameterSetName="Remove", Position=0)]
        [String[]] $Package,

        [Parameter(Mandatory=$False, ParameterSetName="Remove", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Require", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Install", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Update", Position=1)]
        [switch] $Dev,

        [Parameter(Mandatory=$False, ParameterSetName="Init", Position=1)]
        [Parameter(Mandatory=$False, ParameterSetName="Validate", Position=0)]
        [Parameter(Mandatory=$False, ParameterSetName="Get", Position=0)]
        [String] $Path = "$(Get-Location)\require.json"
    )
    
    Write-Verbose "Triggering $($PsCmdlet.ParameterSetName) Block."
    switch ($PsCmdlet.ParameterSetName) 
    {
        "Init"   { 
            Init -Name $Name -Path $Path
        } 
        "Require"   {
            if(!$Dev) { Require -Package $Package }
            else { Require -Package $Package -Branch "require-dev" }
        }
        "Remove"  {  
            if(!$Dev) { Remove -Package $Package }
            else { Remove -Package $Package -Branch "require-dev" }
        }
        "Help"  { 
            Write-Host "Help Block!!"
        }
        "Install"  { 
            if(!$Dev) { Install }
            else { Install -Branch "require-dev" }
        }
        "Update"  { 
            if(!$Dev) { Write-Host "Not Dev" }
            else { Write-Host "Dev" }
        }
        "Get"  { 
            if(!$Path) { Get }
            else {Get -Path $Path }
        }
        "Validate"  { 
            if(!$Path) { Validate }
            else {Validate -Path $Path }
        }                                            
    } 

}