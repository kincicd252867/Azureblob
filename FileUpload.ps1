# Define Variables
$LocalUploadDir = "C:\Users\vincent\Videos\"
$httpsStorageHost = "https://eablobuser.blob.core.windows.net"
$Container = "Videos"
$SASToken = "?sp=racwl&st=2025-06-01T23:19:32Z&se=2025-06-24T07:19:32Z&sip=180.94.149.21x&spr=https&sv=2024-11-04&sr=d&sig=ocL%2FXB9%2B9JbRsNvP5%2BHU2lkrFbnEqpAUsyHrc8VX2Xk%3D&sdd=1"
$storageURI = "$($httpsStorageHost)/$($Container)/$($blobName)$($SASToken)"

# Define required headers
$header = @{
    "x-ms-blob-type" = "BlockBlob"
}

# Get first 10 files in the directory
$localUploadfiles = (Get-ChildItem -Path $LocalUploadDir -File | Select-Object -First 10)

if (-not $localUploadfiles) {
    Write-Error "No files found in $LocalUploadDir."
}

foreach ($file in $localUploadfiles) {
    $blobName = $file.Name
    $LocalUploadPath = $file.FullName
    $storageURI = "$($httpsStorageHost)/$($Container)/$($blobName)$($SASToken)"

 } try {
       Invoke-RestMethod -Uri $storageURI -Method Put -Headers $header -InFile $LocalUploadPath -ErrorAction Stop
       Write-Output "File $blobname uploaded successfully!"
} catch {
    Write-Error "Error uploading file: $LocalUploadPath"
}



