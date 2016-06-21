function Read-PackageList ($Path, $Node)
{
    $json = Read-JsonFile -Path $Path

    $collection = @()
    foreach ($package in ($json.$Node | Get-Member * -MemberType NoteProperty).Name) 
    {
        $meta = $package.Split("/")

        $collection += [PSCustomObject]@{
            Repo    = $meta[0]
            Module  = $meta[1]
            Version = $json.$Node.$package
        }
    }

    return $collection
}