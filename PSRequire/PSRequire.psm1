# Get public and private function definition files.
# $ModulePath = $PSScriptRoot

$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )


# Dot source the files
foreach($import in @($Public + $Private))
{
    try
    {
        Write-Host ("Importing file: `{0}` @ {1}" -f $import, (Get-Date -Format T))
        . $import.fullname
    }
    catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
Export-ModuleMember -Function $Private.Basename