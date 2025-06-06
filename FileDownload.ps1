# Define Variables
$LocalDownloadDir = "D:\Downloads\"    
$httpsStorageHost = "https://eablobuser.blob.core.windows.net"
$Container = "Videos"
$SASToken = "?sp=racwl&st=2025-06-01T23:19:32Z&se=2025-06-24T07:19:32Z&sip=180.94.149.217&spr=https&sv=2024-11-04&sr=d&sig=ocL%2FXB9%2B9JbRsNvP5%2BHU2lkrFbnEqpAUsyHrc8VX2Xk%3D&sdd=1"
$Blobfiles = @(
    "123.mp4",
    "1234.mp4",
    "12345.mp4",
    "12345 - Copy",
    "12345 - Copy (2)",
    "12345 - Copy (3)",
    "12345 - Copy (4)",
    "12345 - Copy (5)",
    "12345 - Copy (6)",
    "12345 - Copy (7)"    
)

# Ensure download directory exists
if (Test-Path -Path $LocalDownloadDir) {
    Write-Output "Download directory exists"
    }
    elseif (-not (Test-Path -Path $LocalDownloadDir)) {
        New-Item -ItemType Directory -Path $LocalDownloadDir
        Write-Output "Download directory created"
}

#Get objects in the blob container
foreach ($file in $Blobfiles) {
    $LocalDownloadPath = Join-Path -Path $LocalDownloadDir -ChildPath $Blobfiles
    $storageURI = "$($httpsStorageHost)/$($Container)/$($BlobName)$($SASToken)"

    try {
    # Download the blob
        Invoke-RestMethod -Uri $storageURI -Method Get -OutFile $LocalDownloadPath -ErrorAction Stop
        Write-Output "File downloaded successfully to: $LocalDownloadDir"
    } catch {
        Write-Error "Download failed: $($_.Exception.Message)"
    }
}
