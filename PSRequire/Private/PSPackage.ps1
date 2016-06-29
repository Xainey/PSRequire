class PSPackage
{
    <#
     # Create a collection from Package Strings
     #>
    static [PSCustomObject] GetPackageList([string[]] $Packages)
    {
        $collection = @()

        foreach ($package in $Packages)
        {
            $meta = $package.Split("/:")

            $collection += [PSCustomObject] @{
                Repository  = $meta[0]
                Module      = $meta[1]
                Version     = $meta[2]
            }
        }

        return $collection
    }

    <#
     # Create a collection from Json Packages
     #>
    static [PSCustomObject] GetPackageList([PSCustomObject] $Json, [string] $Node)
    {
        $collection = @()

        foreach ($package in ($Json.$Node | Get-Member * -MemberType NoteProperty).Name) 
        {
            $meta = $package.Split("/")

            $collection += [PSCustomObject]@{
                Repository  = $meta[0]
                Module      = $meta[1]
                Version     = $Json.$Node.$package
            }   
        }

        return $collection
    }

}