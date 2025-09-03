# Load the necessary assemblies for Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the main form
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "SchoolTools By Nerdiest"
$Form.Size = New-Object System.Drawing.Size(400, 200)
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog" # Prevents resizing
$Form.MaximizeBox = $false # Disables maximize button
$Form.MinimizeBox = $false # Disables minimize button

# Create a label
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "SchoolTools"
$Label.AutoSize = $true # Set to true initially to get the correct label width based on the text
$Label.Font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold) # Use a larger font for better visual impact

# Calculate horizontal center for the label
# This calculation assumes the label is parented by the form.
$centerX = (($Form.Width - $Label.Width) / 2) - 25
$Label.Location = New-Object System.Drawing.Point($centerX, 10)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "By Nerdiest"
$Label2.AutoSize = $true
$Label2.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Italic) # Smaller font, italic style

# Calculate horizontal center for the second label
# It will be centered relative to the form's width, similar to the first label.
# Position it below the first label.
$centerX2 = (($Form.Width - $Label2.Width) / 2) + 5
$Label2.Location = New-Object System.Drawing.Point($centerX2, ($Label1.Bottom + 35)) # Position 10 pixels below the first label

# Create a button
$Button = New-Object System.Windows.Forms.Button
$Button.Text = "Switch to Light Mode"
$Button.Location = New-Object System.Drawing.Point(10, 120)
$Button.Size = New-Object System.Drawing.Size(100, 40)

$Button2 = New-Object System.Windows.Forms.Button
$Button2.Text = "Switch to Dark Mode"
$Button2.Location = New-Object System.Drawing.Point(10, 80)
$Button2.Size = New-Object System.Drawing.Size(100, 40)

$Button3 = New-Object System.Windows.Forms.Button
$Button3.Text = "Default Light Wallpaper"
$Button3.Location = New-Object System.Drawing.Point(145, 120)
$Button3.Size = New-Object System.Drawing.Size(100, 40)

$Button4 = New-Object System.Windows.Forms.Button
$Button4.Text = "Default Dark Wallpaper"
$Button4.Location = New-Object System.Drawing.Point(145, 80)
$Button4.Size = New-Object System.Drawing.Size(100, 40)

$Button5 = New-Object System.Windows.Forms.Button
$Button5.Text = "Custom Wallpaper"
$Button5.Location = New-Object System.Drawing.Point(275, 80)
$Button5.Size = New-Object System.Drawing.Size(100, 40)

# Define an action for the button click event
$Button.Add_Click({
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 1 -Type Dword -Force
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1 -Type Dword -Force
    Stop-Process -Name explorer -Force
    [System.Windows.Forms.MessageBox]::Show("Light mode should be set, please wait! (Note: Your taskbar will return soon!)", "Message", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$Button2.Add_Click({
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force
    Stop-Process -Name explorer -Force
    [System.Windows.Forms.MessageBox]::Show("Dark mode should be set, please wait! (Note: Your taskbar will return soon!)", "Message", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$Button3.Add_Click({
    Copy-Item -Path .\light.jpg -Destination $env:APPDATA\Microsoft\Windows\Themes -Force
    Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper" 
    Rename-Item -Path "$env:APPDATA\Microsoft\Windows\Themes\light.jpg" -NewName "TranscodedWallpaper" -Force
    Stop-Process -Name explorer -Force
    [System.Windows.Forms.MessageBox]::Show("Light mode wallpaper should be set, please wait! (Note: Your taskbar will return soon!)", "Message", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$Button4.Add_Click({
    Copy-Item -Path .\dark.jpg -Destination $env:APPDATA\Microsoft\Windows\Themes -Force
    Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper" 
    Rename-Item -Path "$env:APPDATA\Microsoft\Windows\Themes\dark.jpg" -NewName "TranscodedWallpaper" -Force
    Stop-Process -Name explorer -Force
    [System.Windows.Forms.MessageBox]::Show("Dark mode wallpaper should be set, please wait! (Note: Your taskbar will return soon!)", "Message", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$Button5.Add_Click({
    Add-Type -AssemblyName System.Windows.Forms
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $null = $OpenFileDialog.ShowDialog()
    $FilePath = $OpenFileDialog.FileName
    if ($FilePath) {
        Write-Host "Selected file: $FilePath"
    } else {
        Write-Host "No file selected."
        exit 1
    }
    Copy-Item -Path $FilePath -Destination $env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper -Force
    Stop-Process -Name explorer -Force
    [System.Windows.Forms.MessageBox]::Show("Dark mode wallpaper should be set, please wait! (Note: Your taskbar will return soon!)", "Message", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# Add controls to the form
$Form.Controls.Add($Label2)
$Form.Controls.Add($Label)
$Form.Controls.Add($Button)
$Form.Controls.Add($Button2)
$Form.Controls.Add($Button3)
$Form.Controls.Add($Button4)
$Form.Controls.Add($Button5)

# Display the form
$Form.ShowDialog()