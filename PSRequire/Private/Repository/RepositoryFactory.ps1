class RepositoryFactory
{
    static [Repository[]] $Repositories

    RepositoryFactory()
    {
        $type = $this.GetType()

        if ($type -eq [RepositoryFactory])
        {
            throw("Class should not be instantiated")
        }
    }    

    static [void] addRepo ([String] $Name, [String] $SourceLocation, [String] $Type)
    {
        [Repository] $repo =  (New-Object -TypeName "Repository_$Type" -ArgumentList $Name, $SourceLocation)
        [RepositoryFactory]::Repositories += $repo
    }
}