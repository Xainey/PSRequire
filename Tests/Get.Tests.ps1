$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "Public/Get" {

    $requireFile = "TestDrive:\require.json"

    It "should not throw" {
        Init -Name "test" -Path $requireFile 
        { Get -Path $requireFile } | Should Not Throw
    }

}