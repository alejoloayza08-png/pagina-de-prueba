Add-Type -AssemblyName System.Drawing
$imgPath = "C:\Users\alejo\.gemini\antigravity\brain\43ff539a-1547-4b62-8f40-ac899ee1ec0f\.user_uploaded\media_1788541084092.png"
$img = [System.Drawing.Image]::FromFile($imgPath)
Write-Host "Img size: $($img.Width) x $($img.Height)"

# Function to crop
function Crop-Img($source, $rect, $outputPath) {
    $target = New-Object System.Drawing.Bitmap($rect.Width, $rect.Height)
    $g = [System.Drawing.Graphics]::FromImage($target)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($source, (New-Object System.Drawing.Rectangle(0, 0, $target.Width, $target.Height)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $target.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $g.Dispose()
    $target.Dispose()
    Write-Host "Saved: $outputPath"
}

# The cards in media_1788541084092.png:
# Card 1: approx X: 80, Y: 545, W: 275, H: 430
# Card 2: approx X: 370, Y: 545, W: 275, H: 430
# Card 3: approx X: 660, Y: 545, W: 275, H: 430

Crop-Img $img (New-Object System.Drawing.Rectangle(82, 545, 272, 430)) (Join-Path (Get-Location) "assets\academia-card-1.jpg")
Crop-Img $img (New-Object System.Drawing.Rectangle(372, 545, 272, 430)) (Join-Path (Get-Location) "assets\academia-card-2.jpg")
Crop-Img $img (New-Object System.Drawing.Rectangle(662, 545, 272, 430)) (Join-Path (Get-Location) "assets\academia-card-3.jpg")

$img.Dispose()
