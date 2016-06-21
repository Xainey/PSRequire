$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "Public/Read-JsonFile" {

    It "should not throw" {
        { Read-Jsonfile -Path "$here\..\Examples\require.json" } | Should Not Throw
    }

}