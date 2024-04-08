param (
    [string]$Path
)

function Get-PathInfo {
    param (
        [string]$Path
    )
    
    # Check if the path exists
    if (Test-Path $Path) {
        # Full path: Extract the components
        $Directory = (Get-Item $Path).DirectoryName
        $Filename = (Get-Item $Path).Name
        $ErrorPath = ""
        $Extension = (Get-Item $Path).Extension
        $FilenameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    }
    else {
        $Directory = ""
        $Filename = ""
        $ErrorPath = "Path/Filename not found"
        $Extension = ""
        $FilenameWithoutExtension = ""
    }

    # Output the results
    [PSCustomObject]@{
        Directory = $Directory
        Filename = $Filename
        ErrorPath = $ErrorPath
        Extension = $Extension
        FilenameWithoutExtension = $FilenameWithoutExtension
    }
}

# Call the function with the provided argument
$pathInfo = Get-PathInfo -Path $Path
Write-Host "$($pathInfo.Directory)"
write-host "$($pathinfo.Filename)"
write-host "$($pathinfo.ErrorPath)"
write-host "$($pathinfo.Extension)"
write-host "$($pathinfo.FilenameWithoutExtension)"
