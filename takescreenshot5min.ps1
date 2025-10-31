# Define the path for the Images folder on the desktop
$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$imagesFolder = Join-Path -Path $desktopPath -ChildPath 'Images'

# Create the Images folder if it doesn't exist
if (-not (Test-Path -Path $imagesFolder)) {
    New-Item -ItemType Directory -Path $imagesFolder
}

# Infinite loop to take screenshots every hour
while ($true) {
    # Get the current timestamp for the filename
    $timestamp = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")
    $screenshotPath = Join-Path -Path $imagesFolder -ChildPath ("Screenshot_" + $timestamp + ".png")

    # Take the screenshot
    Add-Type -AssemblyName System.Windows.Forms
    $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $bitmap = New-Object Drawing.Bitmap $bounds.Width, $bounds.Height
    $graphics = [Drawing.Graphics]::FromImage($bitmap)
    $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.Size)
    $bitmap.Save($screenshotPath, [System.Drawing.Imaging.ImageFormat]::Png)

    # Wait for 5 min (300 seconds)
    Start-Sleep -Seconds 300
}