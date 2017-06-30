$pstoolsSource = 'https://download.sysinternals.com/files/PSTools.zip'
$pstoolsZipFile = 'PSTools.zip'
$pstoolsDirectory = 'C:\PSTools'

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip {
    param(
        [String] $zipFile,
        [String] $outFolder,
        [string] $workDirectory
    )

    if ($workDirectory) {
        $zipPath = "$workDirectory\$zipFile"
        $outPath = "$workDirectory\$outFolder"
    }
    else {
        $zipPath = $zipFile
        $outPath = $outFolder
    }

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $outPath)
}

Invoke-WebRequest -Uri $pstoolsSource -OutFile $pstoolsZipFile
$workDir = (Get-Item -Path $pstoolsZipFile).DirectoryName
Unzip "$workDir\$pstoolsZipFile" $pstoolsDirectory
Remove-Item -Path $pstoolsZipFile