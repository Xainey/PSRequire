This Project is a WIP

# CLI Reference

# Init 
Invoke-PSRequire -Init
Invoke-PSRequire -Init -Name "build requirements"
Invoke-PSRequire -Init -Name "build requirements" -Path "c:\temp\path_to_folder\require.json"

# Require
Invoke-PSRequire -Require "PSGallery/PSake:4.6.*"
Invoke-PSRequire -Require ("PSGallery/A:1.1.1", "PSGallery/B:1.1.1")
Invoke-PSRequire -Require ("PSGallery/A:1.1.1", "PSGallery/B:1.1.1") -Dev

# Remove
Invoke-PSRequire -Remove -Package "PSGallery/Psake" -Dev

# Install
Invoke-PSRequire -Install
Invoke-PSRequire -Install -Dev
Invoke-PSRequire -Install -Scope CurrentUser -Force
Invoke-PSRequire -Install -Save

# Update - not implemented
Invoke-PSRequire -Update

# Validate
Invoke-PSRequire -Validate -Path "c:\path_to_folder\require.json"

# Get
Invoke-PSRequire -Get
Invoke-PSRequire -Get -Path "c:\path_to_folder\require.json"

# Help
Invoke-PSRequire -Help


cd c:\temp\path_to_folder\
Invoke-PSRequire -Init -Name "build requirements"
Invoke-PSRequire -Require ("PSGallery/PSake:4.6.*", "PSGallery/PSDeploy:*")
Invoke-PSRequire -Remove "PSGallery/PSDeploy"
Invoke-PSRequire -Get
Invoke-PSRequire -Validate
Invoke-PSRequire -Install -Verbose