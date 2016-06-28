class JsonHandler
{
    [String] $FilePath
    
    <#
     # Constructor
     #>
    JsonHandler([string] $FilePath)
    {
        $extension = [System.IO.Path]::GetExtension($FilePath)

        if($extension -ne ".json")
        {
            throw ("File must be a .json file.")
        }

        $this.FilePath = $FilePath
    }
    
    <#
     # Read the File
     #>
    [PSCustomObject] Read()
    {
        try
        {
            return (Get-Content -Raw -Path $this.FilePath | ConvertFrom-Json)
        } 
        catch 
        {
            throw ("Error converting contents to JSON.")
        }
    }

    <#
     # Write the File
     #>
    [void] Save ([PSCustomObject] $Json)
    {
        $folder = Split-Path -Path $this.FilePath

        if(!(Test-Path -Path $folder))
        {
            New-Item $folder -Type directory -Force
        }

        $Json | ConvertTo-Json | Out-File $this.FilePath -Force
    }

    <#
     # Init the File
     #>
    [void] Init ([HashTable] $Json)
    {
        if(!(Test-Path -Path $this.FilePath))
        {
            $this.Save($Json)
        }
    }

    <#
     # Add to the File
     #>
    [void] Add ([String] $Branch, [HashTable] $Member)
    {
        $Json = $this.Read()

        if(!($Json.$Branch))
        {
            throw("Branch doesnt exist")
        }

        $Json.$Branch = $Json.$Branch | Add-Member $Member -PassThru -Force

        $this.Save($Json)
    }

    <#
     # Remove from the File
     #>
    [void] Remove ([String] $Branch, [String] $Member)
    {
        $Json = $this.Read()

        $Json.$Branch.PSObject.Properties.Remove($Member)

        $this.Save($Json)
    }

    <#
     # Check the File Exists
     #>
    [bool] Exists()
    {
        if (!(Test-Path -Path $this.FilePath))
        {
            return $false
        }

        return $true
    }

    <#
     # Helper to Add to Require Branch given -Dev Switch
     #>
    [void] Require ([HashTable] $Member, [bool] $Dev = $false)
    {
        $Branch = "require"

        if($Dev)
        {
            $Branch = "require-dev"
        }

        $this.Add($Branch, $Member)
    }

    <#
     # Helper to Remove to Require Branch given -Dev Switch
     #>
    [void] Remove ([String] $Member, [bool] $Dev = $false)
    {
        $Branch = "require"

        if($Dev)
        {
            $Branch = "require-dev"
        }

        $this.Remove($Branch, $Member)
    }    

}