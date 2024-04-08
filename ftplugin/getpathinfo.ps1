param (
    [string]$Path
)

function Get-PathInfo {
    param (
        [string]$Path
    )
    
    # Check if the path is a full path or just a filename
    if (Test-Path $Path) {
        # Full path: Extract the directory and filename
        $Directory = (Get-Item $Path).DirectoryName
        $Filename = (Get-Item $Path).Name
        $ErrorPath = ""
    }
    else {
        # Just a filename: Return an empty string for the directory
        $Directory = ""
        $Filename = ""
        $ErrorPath = "Path/Filename not found"
    }

    # Output the results
    [PSCustomObject]@{
        Directory = $Directory
        Filename = $Filename
        ErrorPath = $ErrorPath
    }
}

# Call the function with the provided argument
$pathInfo = Get-PathInfo -Path $Path
Write-Host "$($pathInfo.Directory)"
write-host "$($pathinfo.Filename)"
write-host "$($pathinfo.ErrorPath)"
