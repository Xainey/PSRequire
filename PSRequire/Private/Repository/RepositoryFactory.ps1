class RepositoryFactory
{
    [Repository[]] $Repositories

    <#
     # Constructor
     #>    
    RepositoryFactory()
    {
    }    

    <#
     # Add an Repository base object to $Repositories
     #>    
    [void] addRepo ([String] $Name, [String] $SourceLocation, [String] $Type)
    {
        [Repository] $repo = (New-Object -TypeName "Repository_$Type" -ArgumentList $Name, $SourceLocation)

        if(!$this.isConstraint($repo))
        {
            $this.Repositories += $repo
        }
        else 
        {
            Write-Verbose "Repo with Constraint already Exists: $($repo | Select Name, SourceLocation)"
        }        
    }

    <#
     # get objects from $Repositories by Name
     #>    
    [Object] getByName([String] $Name)
    {
        return $this.Repositories.Where({$_.Name -eq $Name})
    }

    <#
     # Get objects from $Repositories by Type
     #>    
    [Object] getByType([Object] $Object)
    {
        return $this.Repositories.Where({$_ -is $Object})
    }    

    <#
     # Check if the item can be added to the factory
     # Name should more than likely be the UID
     #>
    [Bool] isConstraint([Repository] $Repo)
    {
        $existing = $this.Repositories.Where({
            $_ -is $Repo.GetType() -and $_.Name -eq $Repo.Name
        })

        if($existing.Count -ge 1)
        {
            return $true
        }

        return $false
    }

}