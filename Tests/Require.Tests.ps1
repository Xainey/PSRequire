$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "Public/Require" {

    $requireFile = "TestDrive:\require.json"
    $package = "PSGallery/PSake:4.6.*"
    $badrepo = "NOPE/no:4.6.*"

    It "should not throw" {
        Init -Name "test" -Path $requireFile
        { Require -Package $package -Path $requireFile } | Should Not Throw
    }

    It "should not throw when adding existing package" {
        { Require -Package $package -Path $requireFile } | Should Not Throw
    }    

    It "should not throw when adding non-existant repo" {
        { Require -Package $badrepo -Path $requireFile } | Should Not Throw
    } 

}