function Read-PackageList ($Path)
{
    $json = Read-JsonFile -Path $Path

    foreach ($package in ($json.require | Get-Member * -MemberType NoteProperty).Name) 
    {
        Write-Output "$($package):$($json.require.$package)"
    } 
}