$version = "v2.5"
Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window x:Name="mainWindow"
	xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
	xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
	Background = "Transparent"
	AllowsTransparency="True"
	WindowStyle="None"
	Width="469" SizeToContent="Height"
	MinWidth="330" MinHeight="600"
	MaxWidth="923" MaxHeight="800"
	Top="0" Left="0"
	RenderOptions.BitmapScalingMode="HighQuality">

	<Window.Resources>
	
		<Style x:Key="CustomThumb" TargetType="{x:Type Thumb}">
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type Thumb}">
						<Border Background="#C3C4C4" CornerRadius="3" Margin="0,10,10,10"/>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>

		<Style x:Key="CustomScrollBar" TargetType="{x:Type ScrollBar}">
			<Setter Property="Width" Value="10"/>
			<Setter Property="Background" Value="Transparent"/>
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type ScrollBar}">
						<Grid>
							<Rectangle Width="5" Fill="Black" RadiusX="3" RadiusY="3" Margin="0,10,10,10"/>
							<Track x:Name="PART_Track" IsDirectionReversed="True">
								<Track.Thumb>
									<Thumb Style="{StaticResource CustomThumb}"/>
								</Track.Thumb>
							</Track>
						</Grid>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>

		<Style x:Key="CustomScrollViewerStyle" TargetType="{x:Type ScrollViewer}">
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type ScrollViewer}">
						<Grid>
							<Grid.ColumnDefinitions>
								<ColumnDefinition Width="*"/>
								<ColumnDefinition Width="Auto"/>
							</Grid.ColumnDefinitions>
							<ScrollContentPresenter Grid.Column="0"/>
							<ScrollBar x:Name="PART_VerticalScrollBar" Grid.Column="1" Orientation="Vertical" Style="{StaticResource CustomScrollBar}" Maximum="{TemplateBinding ScrollableHeight}" Value="{TemplateBinding VerticalOffset}" ViewportSize="{TemplateBinding ViewportHeight}"/>
						</Grid>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>
		
		<Style x:Key="RoundHoverButtonStyle" TargetType="{x:Type Button}">
			<Setter Property="Background" Value="Transparent"/>
			<Setter Property="BorderBrush" Value="Transparent"/>
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type Button}">
						<Grid>
							<Ellipse x:Name="circle" Fill="Transparent" Width="{TemplateBinding Width}" Height="{TemplateBinding Height}"/>
							<ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
						</Grid>
						<ControlTemplate.Triggers>
							<Trigger Property="IsMouseOver" Value="True">
								<Setter TargetName="circle" Property="Fill">
									<Setter.Value>
										<SolidColorBrush Color="White" Opacity="0.5"/>
									</Setter.Value>
								</Setter>
							</Trigger>
						</ControlTemplate.Triggers>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>
		
		<Style x:Key="CustomListBoxItemStyle" TargetType="{x:Type ListBoxItem}">
			<Setter Property="Foreground" Value="White"/>
			<Setter Property="Margin" Value="0.5"/>
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type ListBoxItem}">
						<Border Background="{TemplateBinding Background}"
								BorderBrush="{TemplateBinding BorderBrush}"
								BorderThickness="{TemplateBinding BorderThickness}"
								Margin="{TemplateBinding Margin}"
								CornerRadius="5">
							<ContentPresenter/>
						</Border>
						<ControlTemplate.Triggers>
							<Trigger Property="IsMouseOver" Value="True">
								<Setter Property="Background" Value="#80FFFFFF"/>
								<Setter Property="BorderThickness" Value="1"/>
								<Setter Property="BorderBrush" Value="#80FFFFFF"/>
							</Trigger>
						</ControlTemplate.Triggers>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>
		
	</Window.Resources>

	<WindowChrome.WindowChrome>
		<WindowChrome ResizeBorderThickness="5,0,5,5"/>
	</WindowChrome.WindowChrome>

	<Border BorderBrush="Transparent" BorderThickness="0" Background="#272728" CornerRadius="5">
		<Grid>
			<Grid.RowDefinitions>
				<RowDefinition Height="60"/>
				<RowDefinition Height="*"/>
				<RowDefinition Height="Auto"/>
			</Grid.RowDefinitions>
			<Grid Grid.Row="0">
				<Border Background="#E37222" CornerRadius="5,5,0,0"/>
				<Image x:Name="logo" Width="130" Height="60" HorizontalAlignment="Left" VerticalAlignment="Center" Margin="15,10,0,5"/>
				<Button x:Name="superSecretButton" Width="6" Height="6" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Left" Margin="139,23,0,0"/>
				<Button x:Name="peButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,150,0"/>
				<Button x:Name="refreshButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,115,0" ToolTip="Reload Plugins"/>
				<Button x:Name="minimizeButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,80,0" ToolTip="Minimize"/>
				<Button x:Name="columnButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,45,0"/>
				<Button x:Name="closeButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,10,0" ToolTip="Close"/>
			</Grid>
			<ScrollViewer x:Name="ScrollViewer" Grid.Row="1" VerticalScrollBarVisibility="Visible" Style="{StaticResource CustomScrollViewerStyle}">
				<WrapPanel x:Name="pluginStackPanel" Orientation="Horizontal" Margin="10,0,0,10"/>
			</ScrollViewer>
			<Grid Grid.Row="2" Margin="10,0,10,10">
				<Rectangle Height="20" Fill="#C3C4C4" RadiusX="5" RadiusY="5"/>
				<TextBlock x:Name="statusBarStatus" Foreground="Black" FontSize="10" HorizontalAlignment="Left" VerticalAlignment="Center" Margin="10,0,0,0"/>
				<TextBlock x:Name="statusBarVersion" Foreground="Black" FontSize="10" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,0,10,0"/>
			</Grid>
		</Grid>
	</Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Get script path, method compatible with ps2exe
if ($MyInvocation.MyCommand.CommandType -eq "ExternalScript") {
	$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
	$scriptFullPath = $MyInvocation.MyCommand.Definition
} else { 
	$scriptFullPath = ([Environment]::GetCommandLineArgs()[0])
	$scriptPath = Split-Path -Parent -Path $scriptFullPath
}

# Set registry value based on the script extension
$scriptExtension = [System.IO.Path]::GetExtension($scriptFullPath)
if ($scriptExtension -eq ".ps1") {
	$atomPath = $scriptPath
	$scriptFullPath = $MyInvocation.MyCommand.Path
	$registryValue = "cmd /c `"start /b powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptFullPath`"`""
} elseif ($scriptExtension -eq ".exe") {
	$atomPath = Join-Path $scriptPath "ATOM"
	$registryValue = $scriptFullPath
}

# Launch ATOM on reboot
$runOncePath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
New-ItemProperty -Path $runOncePath -Name "ATOM" -Value $registryValue -Force | Out-Null

$drivePath = Split-Path -Qualifier $PSScriptRoot
$logsPath = Join-Path $atomPath "Logs"
$dependenciesPath = Join-Path $atomPath "Dependencies"
$audioPath = Join-Path $dependenciesPath "Audio"
$iconsPath = Join-Path $dependenciesPath "Icons"
$pluginIconsPath = Join-Path $iconsPath "Plugins"
$quipPath = Join-Path $dependenciesPath "Quippy.ps1"
Invoke-Expression -Command (Get-Content $quipPath | Out-String)

$mainWindow = $window.FindName("mainWindow")
$mainWindow.Title = "ATOM $version"
$logo = $window.FindName("logo")
$peButton = $window.FindName("peButton")
$superSecretButton = $window.FindName("superSecretButton")
$refreshButton = $window.FindName("refreshButton")
$minimizeButton = $window.FindName("minimizeButton")
$columnButton = $window.FindName("columnButton")
$closeButton = $window.FindName("closeButton")
$pluginStackPanel = $window.FindName("pluginStackPanel")
$statusBarStatus = $window.FindName("statusBarStatus")
$statusBarVersion = $window.FindName("statusBarVersion")
$statusBarVersion.Text = "$version"

$fontPath = Join-Path $dependenciesPath "Fonts\OpenSans-Regular.ttf"
$fontFamily = New-Object Windows.Media.FontFamily "file:///$fontPath#Open Sans"
$window.FontFamily = $fontFamily

$logo.Source = Join-Path $iconsPath "ATOM Logo.png"

function Set-ButtonIcon ($button, $iconName) {
	$uri = New-Object System.Uri (Join-Path $iconsPath "$iconName.png")
	$img = New-Object System.Windows.Media.Imaging.BitmapImage $uri
	$button.Content = New-Object System.Windows.Controls.Image -Property @{ Source = $img }
}

$buttons = @{ "Refresh" = $refreshButton; "Minimize" = $minimizeButton; "Close" = $closeButton }
$buttons.GetEnumerator() | %{ Set-ButtonIcon $_.Value $_.Key }

$inPE = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\MiniNT"
$pePath = Join-Path $drivePath "sources\boot.wim"
$peOnDrive = Test-Path $pePath
if ($inPE) {
	Set-ButtonIcon $peButton "MountOS"
	$peButton.ToolTip = "Launch MountOS"
	
	$peButton.Add_Click({
		$mountOS = Join-Path $dependenciesPath "MountOS.ps1"
		Start-Process powershell -WindowStyle Hidden -ArgumentList "-ExecutionPolicy Bypass -File `"$mountOS`""
	})
} elseif ($peOnDrive) {
	Set-ButtonIcon $peButton "Reboot2PE"
	$peButton.ToolTip = "Reboot to PE"
	
	$peButton.Add_Click({
		$boot2PE = Join-Path $dependenciesPath "Boot2PE.bat"
		Start-Process cmd.exe -WindowStyle Hidden -ArgumentList "/c `"$boot2PE`""
	})
} else {
	$peButton.isEnabled = $false
}

if (!$inPE) {
	# Output BitLocker key to text file in log path
	$onlineOS = (Get-WmiObject -Class Win32_OperatingSystem).SystemDrive
	$currentDateTime = Get-Date -Format "MMddyy_HHmmss"
	$logFile = Join-Path $logsPath "EncryptionKey-$currentDateTime.txt"
	$encryptionKey = (manage-bde -protectors -get $onlineOS | Select-String -Pattern '\d{6}-\d{6}-\d{6}-\d{6}-\d{6}-\d{6}-\d{6}-\d{6}').Matches.Value
	$encryptionKey | Out-File -Append $logFile

	$oldLogs = Get-ChildItem $logsPath\EncryptionKey-*.txt | Sort-Object CreationTime -Descending | Select-Object -Skip 5
	$oldLogs | Remove-Item -Force
}

function Load-Scripts {
	$pluginStackPanel.Children.Clear()
	$pluginFolders = Get-ChildItem -Path $atomPath -Directory | Where-Object { $_.Name -like "Plugins -*" } | Sort-Object Name
	
	foreach ($pluginFolder in $pluginFolders) {
		$header = $pluginFolder.Name -replace '^Plugins - ',''
		$grid = New-Object System.Windows.Controls.Grid
		$grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition))
		$grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition))
		$grid.Margin = "0,0,10,0"
		
		$textBlock = New-Object System.Windows.Controls.TextBlock
		$textBlock.Text = $header
		$textBlock.Foreground = 'White'
		$textBlock.FontSize = 14
		$textBlock.Margin = "0,10,0,0"
		$textBlock.VerticalAlignment = [System.Windows.VerticalAlignment]::Bottom
		$grid.Children.Add($textBlock) | Out-Null

		$border = New-Object System.Windows.Controls.Border
		$border.CornerRadius = [System.Windows.CornerRadius]::new(5)
		$border.Background = "#49494A"
		$border.Margin = "0,5,0,0"
		$border.SetValue([System.Windows.Controls.Grid]::RowProperty, 1)

		$listBox = New-Object System.Windows.Controls.ListBox
		$listBox.Background = "#49494A"
		$listBox.Foreground = 'White'
		$listBox.BorderThickness = 0
		$listBox.Margin = 5
		$listBox.Padding = 0
		$listBox.Width = 200

		$border.Child = $listBox
		
		$grid.Children.Add($border) | Out-Null
		$grid.RowDefinitions[0].Height = [System.Windows.GridLength]::new(30)
		$pluginStackPanel.Children.Add($grid) | Out-Null
		
		$files = Get-ChildItem -Path $pluginFolder.FullName -Include *.ps1, *.bat, *.exe, *.lnk -Recurse | Sort-Object Name
		
		foreach ($file in $files) {
			$nameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
			
			$iconPath = Join-Path $pluginIconsPath ("$nameWithoutExtension.png")
			$imageExists = Test-Path $iconPath
			
			if (!$imageExists) {
				if ($nameWithoutExtension -match "^[A-Z]") {
					$firstLetter = $nameWithoutExtension.Substring(0,1)
					$iconPath = Join-Path $iconsPath "\Default\Default$firstLetter.png"
				} else {
					$iconPath = $defaultIconPath
				}
			}

			$listBoxItem = New-Object System.Windows.Controls.ListBoxItem
			$listBoxItem.Tag = $file.FullName
			$listBoxItem.Foreground = 'White'

			$stackPanel = New-Object System.Windows.Controls.StackPanel
			$stackPanel.Orientation = [System.Windows.Controls.Orientation]::Horizontal

			$image = New-Object System.Windows.Controls.Image
			$image.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri $iconPath)
			$image.Width = 16
			$image.Height = 16
			$stackPanel.Children.Add($image) | Out-Null

			$textBlock = New-Object System.Windows.Controls.TextBlock
			$textBlock.Text = $nameWithoutExtension
			$textBlock.Margin = New-Object System.Windows.Thickness(5,0,0,0)
			$textBlock.VerticalAlignment = [System.Windows.VerticalAlignment]::Center

			$stackPanel.Children.Add($textBlock) | Out-Null

			$listBoxItem.Content = $stackPanel	
			
			$listBoxItem.add_MouseDoubleClick({
				$selectedFile = $_.Source.Tag
				if ($selectedFile -match '\.ps1$') {
					if ((Get-Content $selectedFile -First 1) -eq "# Launch: Hidden") {
						Start-Process powershell -WindowStyle Hidden -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$selectedFile`""
					} else {
						Start-Process powershell.exe -ArgumentList "-ExecutionPolicy", "Bypass", "-File", "`"$selectedFile`""
					}
				} elseif ($selectedFile -match '\.bat$') {
					if ((Get-Content $selectedFile -First 1) -eq "REM Launch: Hidden") {
						Start-Process cmd.exe -WindowStyle Hidden -ArgumentList "/c `"$selectedFile`""
					} else {
						Start-Process -FilePath "`"$selectedFile`""
					}
				} elseif ($selectedFile -match '\.exe$' -or $selectedFile -match '\.lnk$') {
					Start-Process -FilePath "`"$selectedFile`""
				}
				$nameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($selectedFile)
				$statusBarStatus.Text = "Running $nameWithoutExtension"
			})
			$listBoxItem.Style = $window.FindResource("CustomListBoxItemStyle")
			$listBox.Items.Add($listBoxItem) | Out-Null
		}
	}
}

Load-Scripts

function Refresh-StatusBar {
	$randomQuip = Get-Random -InputObject $quips -Count 1
	$statusBarStatus.Text = "$randomQuip"
}

Refresh-StatusBar

function Spin-RefreshButton {
	$animation = New-Object System.Windows.Media.Animation.DoubleAnimation
	$animation.From = 0
	$animation.To = 360
	$animation.Duration = New-Object Windows.Duration (New-Object TimeSpan 0,0,0,0,500)

	$animation.Easingfunction = New-Object System.Windows.Media.Animation.QuadraticEase
	$animation.Easingfunction.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseInOut

	$rotateTransform = New-Object System.Windows.Media.RotateTransform
	$refreshButton.RenderTransform = $rotateTransform
	$refreshButton.RenderTransformOrigin = '0.5,0.5'

	$rotateTransform.BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty, $animation)
}

$refreshButton.Add_Click({
	Spin-RefreshButton
	Refresh-StatusBar
	Load-Scripts
	$window.SizeToContent = 'Height'
})

function Update-ExpandCollapseButton {
	if ($window.Width -gt 332 -and $window.Width -le 469) {
		$columnButton.ToolTip = "One-Column View"
		Set-ButtonIcon $columnButton "Column-1"
	} else {
		$columnButton.ToolTip = "Two-Column View"
		Set-ButtonIcon $columnButton "Column-2"
	}
}

Update-ExpandCollapseButton

$columnButton.Add_Click({
	$children = $pluginStackPanel.Children | ForEach-Object { $_ }
	$pluginStackPanel.Children.Clear()
	if ($window.Width -gt 332 -and $window.Width -le 469) { $window.Width = 330 } else { $window.Width = 469 }
	$children | ForEach-Object { $pluginStackPanel.Children.Add($_) }
})

$window.Add_SizeChanged({ Update-ExpandCollapseButton })

$minimizeButton.Add_Click({ $window.WindowState = 'Minimized' })

$closeButton.Add_Click({
	Remove-ItemProperty -Path $runOncePath -Name "ATOM" -Force | Out-Null
	$window.Close()
})

$superSecretButton.Add_Click({
	$wavFiles = Get-ChildItem -Path "$audioPath\Random" -Filter "*.wav"
	$randomWav = $wavFiles | Get-Random
	$secretAudio = New-Object System.Media.SoundPlayer
	$secretAudio.SoundLocation = $randomWav.FullName
	$secretAudio.Play()
})

$window.FindName("ScrollViewer").AddHandler([System.Windows.UIElement]::MouseWheelEvent, [System.Windows.Input.MouseWheelEventHandler]{ param($sender, $e) $sender.ScrollToVerticalOffset($sender.VerticalOffset - $e.Delta) }, $true)

# Handle window dragging
$window.Add_MouseLeftButtonDown({$this.DragMove()})

# Finds the resolution of the primary display and the display scaling setting
# If the "effective" resolution will cause ATOM's window to clip, it will decrease the window size
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Display
{
	[DllImport("user32.dll")] public static extern IntPtr GetDC(IntPtr hwnd);
	[DllImport("gdi32.dll")] public static extern int GetDeviceCaps(IntPtr hdc, int nIndex);
	public static int GetScreenHeight() { return GetDeviceCaps(GetDC(IntPtr.Zero), 10); }
	public static int GetScalingFactor() { return GetDeviceCaps(GetDC(IntPtr.Zero), 88); }
}
"@

$scalingDecimal = [Display]::GetScalingFactor()/ 96
$effectiveVertRes = ([double][Display]::GetScreenHeight()/ $scalingDecimal)
if ($effectiveVertRes -le (0.9 * $window.MaxHeight)) {
	$window.MinHeight = 0.6 * $effectiveVertRes
	$window.MaxHeight = 0.9 * $effectiveVertRes
}

$window.ShowDialog() | Out-Null