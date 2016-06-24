function Read-PackageList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, ParameterSetName="Json")]
        [PSCustomObject] $Json,
        [string] $Node,

        [Parameter(Mandatory=$true, ParameterSetName="String")]
        [string[]] $Packages
    )

    $collection = @()

    if ($PsCmdlet.ParameterSetName -eq "Json") 
    {
        foreach ($package in ($Json.$Node | Get-Member * -MemberType NoteProperty).Name) 
        {
            $meta = $package.Split("/")

            $collection += [PSCustomObject]@{
                Repository  = $meta[0]
                Module      = $meta[1]
                Version     = $Json.$Node.$package
            }
        }   
    }

    if ($PsCmdlet.ParameterSetName -eq "String") 
    {
        foreach ($package in $Packages) 
        {
            $meta = $package.Split("/:")

            $collection += [PSCustomObject]@{
                Repository  = $meta[0]
                Module      = $meta[1]
                Version     = $meta[2]
            }
        }   
    }

    return $collection
}