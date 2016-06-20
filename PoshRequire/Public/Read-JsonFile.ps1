function Read-JsonFile ($Path) 
{
    return Get-Content -Raw -Path $Path | ConvertFrom-Json
}