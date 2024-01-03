# Launch: Hidden

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Drawing

[xml]$xaml = @"
<Window
	xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
	xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
	Title="Detectron"
	WindowStartupLocation="CenterScreen"
	WindowStyle="None"
	AllowsTransparency="True"
	Background="Transparent"
	Width="600" Height="800"
	MinWidth="400" MinHeight="600"
	MaxWidth="800" MaxHeight="1000"
	RenderOptions.BitmapScalingMode="HighQuality">
	
	<Window.Resources>
	
		<SolidColorBrush x:Key="primaryColor" Color="#E37222"/>
		<SolidColorBrush x:Key="primaryText" Color="Black"/>
		<SolidColorBrush x:Key="primaryHighlight" Color="#80FFFFFF"/>
		
		<SolidColorBrush x:Key="secondaryColor1" Color="#49494A"/>
		<SolidColorBrush x:Key="secondaryColor2" Color="#272728"/>
		<SolidColorBrush x:Key="secondaryText" Color="White"/>
		<SolidColorBrush x:Key="secondaryHighlight" Color="#80FFFFFF"/>
		
		<SolidColorBrush x:Key="accentColor" Color="#C3C4C4"/>
		<SolidColorBrush x:Key="accentText" Color="Black"/>
		<SolidColorBrush x:Key="accentHighlight" Color="#80FFFFFF"/>
	
		<Style x:Key="CustomThumb" TargetType="{x:Type Thumb}">
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type Thumb}">
						<Border Background="{DynamicResource accentColor}" CornerRadius="3" Margin="0,10,10,10"/>
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
							<Rectangle Width="5" Fill="{DynamicResource accentHighlight}" RadiusX="3" RadiusY="3" Margin="0,10,10,10"/>
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
		
		<Style x:Key="RoundedButton" TargetType="{x:Type Button}">
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type Button}">
						<Border x:Name="border" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="0" CornerRadius="5" Padding="2.5">
							<ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
						</Border>
						<ControlTemplate.Triggers>
							<Trigger Property="IsMouseOver" Value="True">
								<Setter TargetName="border" Property="Background" Value="{DynamicResource secondaryHighlight}"/>
							</Trigger>
						</ControlTemplate.Triggers>
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
										<SolidColorBrush Color="#80FFFFFF"/>
									</Setter.Value>
								</Setter>
							</Trigger>
						</ControlTemplate.Triggers>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>
		
		<Style TargetType="ListBoxItem">
			<Setter Property="Foreground" Value="{DynamicResource secondaryText}"/>
			<Setter Property="Margin" Value="1"/>
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
							<Trigger Property="IsSelected" Value="True">
								<Setter Property="Background" Value="#737474"/>
							</Trigger>
						</ControlTemplate.Triggers>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>
		
		<Style x:Key="CustomListBoxStyle" TargetType="{x:Type ListBox}">
			<Setter Property="BorderBrush" Value="Transparent"/>
			<Setter Property="Background" Value="Transparent"/>
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type ListBox}">
						<Border Background="{TemplateBinding Background}"
								BorderBrush="{TemplateBinding BorderBrush}"
								BorderThickness="1"
								CornerRadius="5"
								Padding="5"> 
							<ScrollViewer Focusable="false">
								<StackPanel IsItemsHost="True"/>
							</ScrollViewer>
						</Border>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>

		<Style x:Key="CustomListBoxItemStyle" TargetType="{x:Type ListBoxItem}">
			<Setter Property="Foreground" Value="{DynamicResource secondaryText}"/>
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
		
		<Style x:Key="CustomCheckBoxStyle" TargetType="{x:Type CheckBox}">
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="{x:Type CheckBox}">
						<Grid>
							<Grid.ColumnDefinitions>
								<ColumnDefinition Width="Auto"/>
								<ColumnDefinition Width="*"/>
							</Grid.ColumnDefinitions>
							<Image x:Name="PART_Image" Width="20" Height="20"/>
							<ContentPresenter Grid.Column="1" Margin="5,0,0,0" VerticalAlignment="Center"/>
						</Grid>
						<ControlTemplate.Triggers>
							<Trigger Property="IsChecked" Value="True">
								<Setter TargetName="PART_Image" Property="Source" Value="{DynamicResource CheckedImage}"/>
							</Trigger>
							<Trigger Property="IsChecked" Value="False">
								<Setter TargetName="PART_Image" Property="Source" Value="{DynamicResource UncheckedImage}"/>
							</Trigger>
						</ControlTemplate.Triggers>
					</ControlTemplate>
				</Setter.Value>
			</Setter>
		</Style>

	</Window.Resources>
	
	<WindowChrome.WindowChrome>
		<WindowChrome CaptionHeight="0" CornerRadius="10"/>
	</WindowChrome.WindowChrome>
	
	<Border BorderBrush="Transparent" BorderThickness="1" Background="{DynamicResource secondaryColor2}" CornerRadius="5">
		<Grid>
			<Grid.RowDefinitions>
				<RowDefinition Height="60"/>
				<RowDefinition Height="*"/>
				<RowDefinition Height="Auto"/>
			</Grid.RowDefinitions>
			
			<Grid Grid.Row="0">
				<Border Background="{DynamicResource primaryColor}" CornerRadius="5,5,0,0"/>
				<Image Name="logo" Width="40" Height="40" HorizontalAlignment="Left" VerticalAlignment="Center" Margin="10,10,0,5"/>
				<TextBlock Text="D E T E C T R O N" Foreground="{DynamicResource primaryText}" FontSize="20" FontWeight="Bold" HorizontalAlignment="Left" VerticalAlignment="Center" Margin="60,10,0,5"/>
				<Button Name="minimizeButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,45,0" ToolTip="Minimize"/>
				<Button Name="closeButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,10,0" ToolTip="Close"/>
			</Grid>
			
			<Grid Grid.Row="1" Margin="0">
				<Grid.ColumnDefinitions>
					<ColumnDefinition Width="*"/>
					<ColumnDefinition Width="*"/>
				</Grid.ColumnDefinitions>
				
				<ScrollViewer Name="scrollViewer0" Grid.Column="0" VerticalScrollBarVisibility="Auto" Style="{StaticResource CustomScrollViewerStyle}">
					<StackPanel Name="uninstallPanel" Margin="0,10,10,5"/>
				</ScrollViewer>
				
				<Border Grid.Column="1" CornerRadius="5" Background="{DynamicResource secondaryColor1}" Margin="5,10,10,0">
					<ScrollViewer Name="scrollViewer1" Grid.Column="1" VerticalScrollBarVisibility="Auto" Style="{StaticResource CustomScrollViewerStyle}">
						<TextBlock Name="outputBox" Foreground="{DynamicResource secondaryText}" HorizontalAlignment="Stretch" TextWrapping="Wrap" VerticalAlignment="Stretch" Padding="10"/>
					</ScrollViewer>
				</Border>
			</Grid>
			
			<Grid Grid.Row="2">
				<Button Name="runButton" Content="Run" Background="{DynamicResource accentColor}" Foreground="{DynamicResource accentText}" Margin="10" Style="{StaticResource RoundedButton}"/>
			</Grid>
			
		</Grid>
	</Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$atomPath = Split-Path (Split-Path $MyInvocation.MyCommand.Path -Parent) -Parent
$dependenciesPath = Join-Path $atomPath "Dependencies"
$iconsPath = Join-Path $dependenciesPath "Icons"
$settingsPath = Join-Path $dependenciesPath "Settings"
$programIcons = Join-Path $iconsPath "Plugins"
$detectronDependencies = Join-Path $dependenciesPath "Detectron"
$detectronFunctions = Join-Path $detectronDependencies "Functions"
$detectronOptimizations = Join-Path $detectronDependencies "Optimizations"
$detectronPanels = Join-Path $detectronDependencies "Panels"
$detectronPrograms = Join-Path $detectronDependencies "Programs"

$logo = $window.FindName("logo")
$minimizeButton = $window.FindName("minimizeButton")
$closeButton = $window.FindName("closeButton")
$runButton = $window.Findname('runButton')
$uninstallPanel = $window.FindName('uninstallPanel')
$outputBox = $window.FindName('outputBox')

$colorsPath = Join-Path $settingsPath "Colors-Custom.ps1"
. $colorsPath

$fontPath = Join-Path $dependenciesPath "Fonts\OpenSans-Regular.ttf"
$fontFamily = New-Object Windows.Media.FontFamily "file:///$fontPath#Open Sans"
$window.FontFamily = $fontFamily

$logo.Source = Join-Path $iconsPath "Plugins\Detectron.png"

if ($secondaryIcons -eq "Light") {
	$checkedImagePath = Join-Path $iconsPath "Checkbox - Checked (Light).png"
	$uncheckedImagePath = Join-Path $iconsPath "Checkbox - Unchecked (Light).png"
} else {
	$checkedImagePath = Join-Path $iconsPath "Checkbox - Checked (Dark).png"
	$uncheckedImagePath = Join-Path $iconsPath "Checkbox - Unchecked (Dark).png"
}

$checkedImage = New-Object -TypeName System.Windows.Media.Imaging.BitmapImage -ArgumentList (New-Object -TypeName System.Uri -ArgumentList $checkedImagePath)
$uncheckedImage = New-Object -TypeName System.Windows.Media.Imaging.BitmapImage -ArgumentList (New-Object -TypeName System.Uri -ArgumentList $uncheckedImagePath)
$window.Resources.Add("CheckedImage", $checkedImage)
$window.Resources.Add("UncheckedImage", $uncheckedImage)

if ($primaryIcons -eq "Light") {
	$buttons = @{ "Minimize (Light)" = $minimizeButton; "Close (Light)" = $closeButton }
} else {
	$buttons = @{ "Minimize (Dark)" = $minimizeButton; "Close (Dark)" = $closeButton }
}

$buttons.GetEnumerator() | %{
	$uri = New-Object System.Uri (Join-Path $iconsPath "$($_.Key).png")
	$img = New-Object System.Windows.Media.Imaging.BitmapImage $uri
	$_.Value.Content = New-Object System.Windows.Controls.Image -Property @{ Source = $img }
}

# Browser notifications
$panelNotifications = Join-Path $detectronPanels "Panel-Notifications.ps1"
. $panelNotifications

# Construct optimizations panel
$panelOptimizations = Join-Path $detectronPanels "Panel-Optimizations.ps1"
. $panelOptimizations

# Construct uninstallers panel
$panelPrograms = Join-Path $detectronPanels "Panel-Programs.ps1"
. $panelPrograms

# Construct apps panel
$panelApps = Join-Path $detectronPanels "Panel-Apps.ps1"
. $panelApps

0..1 | % { $window.FindName("scrollViewer$_").AddHandler([System.Windows.UIElement]::MouseWheelEvent, [System.Windows.Input.MouseWheelEventHandler]{ param($sender, $e) $sender.ScrollToVerticalOffset($sender.VerticalOffset - $e.Delta) }, $true) }
$minimizeButton.Add_Click({ $window.WindowState = 'Minimized' })
$closeButton.Add_Click({ $window.Close() })
$window.Add_MouseLeftButtonDown({ $this.DragMove() })

# Remove ScreenConnectClient if detected
$netPath = Join-Path $env:localappdata "Apps\2.0"
$files = Get-ChildItem -Path $netPath -Filter "screen*.exe" -Recurse -File -ErrorAction SilentlyContinue
if ($files) { 
	Get-Process | Where-Object { $_.Name -like "screenconnect*" } | Stop-Process -Force
	$files | ForEach-Object { Remove-Item $_.Directory.FullName -Recurse -Force }
	$outputBox.Text = "ScreenConnectClient removed."
}

$runButton.Tooltip = "- Perform selected optimizations `n- Uninstall selected apps"
$runButton.Add_Click({
	$scrollToEnd = $window.FindName("scrollViewer1").ScrollToEnd()
	
	$selectedScripts = ($optimizationsItems | Where-Object { $_.IsChecked -eq $true } | ForEach-Object { $_.Tag }) -join ";"
	$selectedPrograms = $listBoxes.Values | ForEach-Object { $_.Items } | Where-Object { $_.IsChecked } | ForEach-Object { $_.Tag }
	$selectedApps = $appxListBox.Items | Where-Object { $_.IsChecked } | ForEach-Object { $_.Tag }

	$runspace = [runspacefactory]::CreateRunspace()
	$runspace.ApartmentState = "STA"
	$runspace.ThreadOptions = "ReuseThread"
	$runspace.Open()
	
	$runspace.SessionStateProxy.SetVariable('outputBox', $outputBox)
	$runspace.SessionStateProxy.SetVariable('runButton', $runButton)
	$runspace.SessionStateProxy.SetVariable('optimizationsItems', $optimizationsItems)
	$runspace.SessionStateProxy.SetVariable('detectronFunctions', $detectronFunctions)
	$runspace.SessionStateProxy.SetVariable('detectronPrograms', $detectronPrograms)
	$runspace.SessionStateProxy.SetVariable('uninstallPaths', $uninstallPaths)
	
	$runspace.SessionStateProxy.SetVariable('selectedScripts', $selectedScripts)
	$runspace.SessionStateProxy.SetVariable('selectedPrograms', $selectedPrograms)
	$runspace.SessionStateProxy.SetVariable('listBoxes', $listBoxes)
	$runspace.SessionStateProxy.SetVariable('selectedApps', $selectedApps)
	
	$powershell = [powershell]::Create().AddScript({
		function Write-OutputBox {
			param([string]$Text)
			$outputBox.Dispatcher.Invoke([action]{ $outputBox.Text += "$Text`r`n"; $scrollToEnd }, "Render")
		}
		
		$runButton.Dispatcher.Invoke([action]{ $runButton.Content = "Running..."; $runButton.IsEnabled = $false }, "Render")

		Get-ChildItem -Path $detectronPrograms -Filter *.ps1 | ForEach-Object {
			Invoke-Expression -Command (Get-Content $_.FullName | Out-String)
		}
		
		Get-ChildItem -Path $detectronFunctions -Filter *.ps1 | ForEach-Object {
			Invoke-Expression -Command (Get-Content $_.FullName | Out-String)
		}
		
		Perform-Optimizations
		Uninstall-Programs
		Uninstall-Apps
		
		try {
			$outputText = $outputBox.Dispatcher.Invoke([Func[string]]{ $outputBox.Text })
			$dateTime = Get-Date -Format "yyyyMMdd_HHmmss"
			$logPath = Join-Path $env:TEMP "detectron-$dateTime.txt"
			$outputText | Out-File -FilePath $logPath
			Write-OutputBox "Log saved to $logPath"
		} catch {
			Write-OutputBox "Failed to save log"
		}
		
		Write-OutputBox "`nDetectron finished."
		
		$runButton.Dispatcher.Invoke([action]{ $runButton.Content = "Run"; $runButton.IsEnabled = $true }, "Render")
	})
	$powershell.Runspace = $runspace
	$null = $powershell.BeginInvoke()
})

# Finds the resolution of the primary display and the display scaling setting
# If the "effective" resolution will cause Neutron's window to clip, it will decrease the window size
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
if ($effectiveVertRes -le (1.0 * $window.MaxHeight)) {
	$window.MinHeight = 0.6 * $effectiveVertRes
	$window.MaxHeight = 0.9 * $effectiveVertRes
}

$window.ShowDialog() | Out-Null