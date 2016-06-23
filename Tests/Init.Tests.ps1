$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "Public/Init" {

    $requireFile = "TestDrive:\require.json"

    It "should not throw" {
        { Init -Name "test" -Path $requireFile } | Should Not Throw
    }

    It "should not overwrite" {
        Init -Name "test" -Path $requireFile | Should Be "File require.json already exists."
    }    

}