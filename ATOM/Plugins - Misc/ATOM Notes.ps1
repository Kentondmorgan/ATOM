# Launch: Hidden

$version = "v1.2"
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

$xaml = @"
<Window Name="mainWindow"
	xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
	xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
	Topmost="True"
	WindowStyle="None"
	AllowsTransparency="True"
	Background="Transparent"
	Height="400" Width="600"
	MinHeight="60" MinWidth="600"
	MaxWidth="1000"
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
	
		<Style TargetType="TextBox">
			<Setter Property="Template">
				<Setter.Value>
					<ControlTemplate TargetType="TextBox">
						<Border Background="{TemplateBinding Background}"
								CornerRadius="5">
							<ScrollViewer Margin="0" x:Name="PART_ContentHost"/>
						</Border>
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
		
	</Window.Resources>
	
	<WindowChrome.WindowChrome>
		<WindowChrome ResizeBorderThickness="5,0,5,5"/>
	</WindowChrome.WindowChrome>
	
	<Border Background="#BF000000" CornerRadius="5">
		<Grid>
			<Grid.RowDefinitions>
				<RowDefinition Height="60"/>
				<RowDefinition Height="60"/>
				<RowDefinition Height="*"/>
			</Grid.RowDefinitions>
			
			<Grid Grid.Row="0">
				<Border Background="#E37222" CornerRadius="5"/>
				<Image Name="logo" Width="40" Height="40" HorizontalAlignment="Left" VerticalAlignment="Center" Margin="10,0,0,0"/>
				<TextBlock Name="title" Text="ATOM Notes" FontSize="20" FontWeight="Bold" VerticalAlignment="Center" Margin="60,0,0,0"/>
				<Button Name="minimizeButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,80,0"/>
				<Button Name="fullscreenButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,45,0"/>
				<Button Name="closeButton" Width="20" Height="20" Style="{StaticResource RoundHoverButtonStyle}" HorizontalAlignment="Right" Margin="0,0,10,0"/>
			</Grid>
			
			<Grid Grid.Row="1" Margin="10,5,0,0">
				<Grid.ColumnDefinitions>
					<ColumnDefinition Width="*"/>
					<ColumnDefinition Width="100"/>
					<ColumnDefinition Width="40"/>
				</Grid.ColumnDefinitions>
				
				<Grid Grid.Column="0" Margin="0">
					<Label Content="Notes" Foreground="White" HorizontalAlignment="Left" VerticalAlignment="Top"/>
					<TextBox Name="txtNote" Foreground="Black" Background="#C3C4C4" HorizontalContentAlignment="Left" VerticalContentAlignment="Center" HorizontalAlignment="Stretch" Height="25" Margin="0,25,0,0" Padding="5,0,0,0" VerticalAlignment="Top"/>
				</Grid>
				
				<Grid Grid.Column="1" Margin="10,0,5,0">
					<Label Content="Initials" Foreground="White" HorizontalAlignment="Center" VerticalAlignment="Top"/>
					<TextBox Name="txtInitials" Foreground="Black" Background="#C3C4C4" HorizontalContentAlignment="Center" VerticalContentAlignment="Center" HorizontalAlignment="Stretch" Height="25" Margin="0,25,0,0" VerticalAlignment="Top" MaxLength="3"/>
				</Grid>
				
				<Grid Grid.Column="2" Margin="0,20,5,0">
					<Button Name="addButton" Background="Transparent" HorizontalAlignment="Center" VerticalAlignment="Center" Height="25" Width="25" Margin="0,0,0,0" Style="{StaticResource RoundHoverButtonStyle}"/>
				</Grid>
			</Grid>
			
			
			<Grid Grid.Row="2" Margin="10,0,0,10">
				<ScrollViewer Name="scrollViewer" VerticalScrollBarVisibility="Auto" Style="{StaticResource CustomScrollViewerStyle}">
					<DataGrid Name="dgNotes" HorizontalAlignment="Stretch" VerticalAlignment="Stretch" Background="Transparent" Foreground="White" Margin="0,0,10,0" BorderThickness="0" Width="Auto" AutoGenerateColumns="False" CanUserAddRows="False" GridLinesVisibility="None" HeadersVisibility="None" ClipToBounds="False">

						<DataGrid.RowStyle>
							<Style TargetType="DataGridRow">
								<Setter Property="BorderThickness" Value="0"/>
								<Setter Property="BorderBrush" Value="Transparent"/>
								<Setter Property="Background" Value="#49494A"/>
								<Setter Property="Margin" Value="0,10,0,0"/>
								<Setter Property="IsSelected" Value="False"/>
								<Setter Property="Selector.IsSelected" Value="False"/>
								<Setter Property="Template">
									<Setter.Value>
										<ControlTemplate TargetType="{x:Type DataGridRow}">
											<Border Name="DGR_Border" BorderBrush="{TemplateBinding BorderBrush}" 
																BorderThickness="{TemplateBinding BorderThickness}" 
																Background="{TemplateBinding Background}" 
																SnapsToDevicePixels="True"
																CornerRadius="5">
												<SelectiveScrollingGrid>
													<SelectiveScrollingGrid.ColumnDefinitions>
														<ColumnDefinition Width="Auto"/>
														<ColumnDefinition Width="*"/>
													</SelectiveScrollingGrid.ColumnDefinitions>
													<SelectiveScrollingGrid.RowDefinitions>
														<RowDefinition Height="*"/>
														<RowDefinition Height="Auto"/>
													</SelectiveScrollingGrid.RowDefinitions>
													<DataGridCellsPresenter Grid.Column="1" ItemsPanel="{TemplateBinding ItemsPanel}" SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}"/>
													<DataGridDetailsPresenter Grid.Column="1" Grid.Row="1" SelectiveScrollingGrid.SelectiveScrollingOrientation="{Binding AreRowDetailsFrozen, ConverterParameter={x:Static SelectiveScrollingOrientation.Vertical}, Converter={x:Static DataGrid.RowDetailsScrollingConverter}, RelativeSource={RelativeSource AncestorType={x:Type DataGrid}}}" Visibility="{TemplateBinding DetailsVisibility}"/>
													<DataGridRowHeader Grid.RowSpan="2" SelectiveScrollingGrid.SelectiveScrollingOrientation="Vertical" Visibility="{Binding HeadersVisibility, ConverterParameter={x:Static DataGridHeadersVisibility.Row}, Converter={x:Static DataGrid.HeadersVisibilityConverter}, RelativeSource={RelativeSource AncestorType={x:Type DataGrid}}}"/>
												</SelectiveScrollingGrid>
											</Border>
										</ControlTemplate>
									</Setter.Value>
								</Setter>
							</Style>
						</DataGrid.RowStyle>
						
						<DataGrid.CellStyle>
							<Style TargetType="DataGridCell">
								<Setter Property="Padding" Value="5"/>
								<Setter Property="Background" Value="#49494A"/>
								<Setter Property="Foreground" Value="White"/>
								<Setter Property="Template">
									<Setter.Value>
										<ControlTemplate TargetType="{x:Type DataGridCell}">
											<Border Padding="{TemplateBinding Padding}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" SnapsToDevicePixels="True">
												<ContentPresenter SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}"/>
											</Border>
										</ControlTemplate>
									</Setter.Value>
								</Setter>
								<Style.Triggers>
									<Trigger Property="IsSelected" Value="True">
										<Setter Property="Background" Value="Transparent"/>
										<Setter Property="BorderBrush" Value="Transparent"/>
									</Trigger>
								</Style.Triggers>
							</Style>
						</DataGrid.CellStyle>
						
						<DataGrid.Columns>
							<DataGridTextColumn Header="Notes" Binding="{Binding Note}" Width="*" IsReadOnly="False">
								<DataGridTextColumn.ElementStyle>
									<Style TargetType="TextBlock">
										<Setter Property="HorizontalAlignment" Value="Left"/>
										<Setter Property="VerticalAlignment" Value="Center"/>
										<Setter Property="TextWrapping" Value="Wrap"/>
									</Style>
								</DataGridTextColumn.ElementStyle>
								<DataGridTextColumn.EditingElementStyle>
									<Style TargetType="TextBox">
										<Setter Property="Foreground" Value="White"/>
										<Setter Property="Background" Value="#49494A"/>
										<Setter Property="BorderThickness" Value="0"/>
									</Style>
								</DataGridTextColumn.EditingElementStyle>
							</DataGridTextColumn>
							
							<DataGridTextColumn Header="Timestamp" Binding="{Binding Timestamp}" Width="130" IsReadOnly="True">
								<DataGridTextColumn.ElementStyle>
									<Style TargetType="TextBlock">
										<Setter Property="HorizontalAlignment" Value="Center"/>
										<Setter Property="VerticalAlignment" Value="Center"/>
										<Setter Property="TextWrapping" Value="Wrap"/>
									</Style>
								</DataGridTextColumn.ElementStyle>
							</DataGridTextColumn>

							<DataGridTextColumn Header="Initials" Binding="{Binding Initials}" Width="60" IsReadOnly="False">
								<DataGridTextColumn.ElementStyle>
									<Style TargetType="TextBlock">
										<Setter Property="HorizontalAlignment" Value="Center"/>
										<Setter Property="VerticalAlignment" Value="Center"/>
										<Setter Property="TextWrapping" Value="Wrap"/>
									</Style>
								</DataGridTextColumn.ElementStyle>
								<DataGridTextColumn.EditingElementStyle>
									<Style TargetType="TextBox">
										<Setter Property="Foreground" Value="White"/>
										<Setter Property="Background" Value="#49494A"/>
										<Setter Property="BorderThickness" Value="0"/>
									</Style>
								</DataGridTextColumn.EditingElementStyle>
							</DataGridTextColumn>
						</DataGrid.Columns>
					</DataGrid>
				</ScrollViewer>
			</Grid>
		</Grid>
	</Border>
</Window>
"@

$window = [System.Windows.Markup.XamlReader]::Parse($xaml)

$atomPath = $MyInvocation.MyCommand.Path | Split-Path | Split-Path
$dependenciesPath = Join-Path $atomPath "Dependencies"
$iconsPath = Join-Path $dependenciesPath "Icons"

$mainWindow = $window.FindName("mainWindow")
$mainWindow.Title = "ATOM Notes $version"
$title = $window.FindName("title")
$logo = $window.FindName("logo")
$minimizeButton = $window.FindName("minimizeButton")
$fullscreenButton = $window.FindName("fullscreenButton")
$closeButton = $window.FindName("closeButton")
$txtNote = $window.FindName('txtNote')
$txtInitials = $window.FindName('txtInitials')
$addButton = $window.FindName('addButton')
$dgNotes = $window.FindName('dgNotes')

$logo.Source = Join-Path $iconsPath "Plugins\ATOM Notes.png"

$fontPath = Join-Path $dependenciesPath "Fonts\OpenSans-Regular.ttf"
$fontFamily = New-Object Windows.Media.FontFamily "file:///$fontPath#Open Sans"
$window.FontFamily = $fontFamily

$screenWidth = [System.Windows.SystemParameters]::PrimaryScreenWidth
$screenHeight = [System.Windows.SystemParameters]::PrimaryScreenHeight
$window.Top = 0
$window.Left = $screenWidth - $window.Width

function Set-ButtonIcon ($button, $iconName) {
	$uri = New-Object System.Uri (Join-Path $iconsPath "$iconName.png")
	$img = New-Object System.Windows.Media.Imaging.BitmapImage $uri
	$button.Content = New-Object System.Windows.Controls.Image -Property @{ Source = $img }
}
$buttons = @{ "Minimize" = $minimizeButton; "WindowCloseFullscreen" = $fullscreenButton;"Close" = $closeButton; "Add" = $addButton }
$buttons.GetEnumerator() | %{ Set-ButtonIcon $_.Value $_.Key }

function Update-FullscreenButton {
	$iconName = if ($window.Height -le 60) { "WindowFullscreen" } else { "WindowCloseFullscreen" }
	Set-ButtonIcon $fullscreenButton $iconName
}

$fullscreenButton.Add_Click({
	if ($window.Height -le 60) {
		$window.SizeToContent = 'Height'
		$window.MinWidth = 600
		$window.Width = 600
		$window.Top = 0
		$window.Left = $screenWidth - $window.Width
		$title.Opacity = "1.0"
	} else {
		$window.SizeToContent = 'Manual'
		$window.Height = 60
		$window.MinWidth = 160
		$window.Width = 160
		$title.Opacity = "0"
	}
})

$window.Add_SizeChanged({ Update-FullscreenButton })
$window.Add_MouseLeftButtonDown({ $this.DragMove() })
$window.FindName("scrollViewer").AddHandler([System.Windows.UIElement]::MouseWheelEvent, [System.Windows.Input.MouseWheelEventHandler]{ param($sender, $e) $sender.ScrollToVerticalOffset($sender.VerticalOffset - $e.Delta) }, $true)

$minimizeButton.Add_Click({ $window.WindowState = 'Minimized' })
$closeButton.Add_Click({ $window.Close() })

$notesCollection = New-Object 'System.Collections.ObjectModel.ObservableCollection[System.Object]'
$dgNotes.ItemsSource = $notesCollection

$enterKeyPressAction = {
	param($sender, $e)
	
	if ($e.Key -eq 'Enter') {
		$addButton.RaiseEvent([System.Windows.RoutedEventArgs]::new([System.Windows.Controls.Primitives.ButtonBase]::ClickEvent))
		$e.Handled = $true
	}
}

$txtNote.Add_KeyDown($enterKeyPressAction)
$txtInitials.Add_KeyDown($enterKeyPressAction)

$tempPath = $env:temp
$notesFile = Join-Path $tempPath "atomNotes.json"
$addButton.Add_Click({
	if ($txtNote.Text -and $txtInitials.Text) {
		$note = @{
			'Timestamp' = (Get-Date).ToString('hh:mm tt | MM/dd/yy')
			'Initials'  = $txtInitials.Text
			'Note'	  = $txtNote.Text
		}

		# Load existing notes or create a new array if the file doesn't exist
		$notes = @()
		if (Test-Path $notesFile) {
			$notes = Get-Content -Path $notesFile -Raw | ConvertFrom-Json
		}

		$notes = @($notes) + $note

		# Save the updated notes array to the JSON file
		$notes | ConvertTo-Json | Set-Content -Path $notesFile

		$notesCollection.Add([PSCustomObject]$note)
		
		$window.FindName("ScrollViewer").ScrollToEnd()

		$txtNote.Clear()
		$txtNote.Focus()
	}
})

function Load-Notes {
	if (Test-Path $notesFile) {
		$notes = Get-Content -Path $notesFile | ConvertFrom-Json
		$notesCollection.Clear()
		foreach ($note in $notes) {
			$notesCollection.Add([PSCustomObject]$note)
		}
	}
}

Load-Notes

$dgNotesRowEditEvent = Register-ObjectEvent -InputObject $dgNotes -EventName RowEditEnding -Action {
	$editedItem = $event.SourceEventArgs.Row.Item
	$notes = Get-Content -Path $global:notesFile -Raw | ConvertFrom-Json

	$notes | ForEach-Object {
		if ($_.Timestamp -eq $editedItem.Timestamp) {
			$_.Note = $editedItem.Note
			$_.Initials = $editedItem.Initials
		}
	}

	$notes | ConvertTo-Json | Set-Content -Path $global:notesFile
}

$dgNotes.Add_PreviewMouseRightButtonDown({
	$row = $dgNotes.InputHitTest($_.GetPosition($dgNotes))
	while ($row -and $row.GetType() -ne [System.Windows.Controls.DataGridRow]) {
		$row = [System.Windows.Media.VisualTreeHelper]::GetParent($row)
	}
	
	if ($row) {
		$selectedItem = $row.Item
		if ($selectedItem) {
			$notesCollection.Remove($selectedItem)
			$jsonData = Get-Content -Path $notesFile -Raw | ConvertFrom-Json
			if ($jsonData -isnot [System.Array]) {
				Remove-Item -Path $notesFile -ErrorAction SilentlyContinue
			} else {
				$notesCollection | ConvertTo-Json | Set-Content -Path $notesFile
			}
		}
	}
})

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
	public static int GetScreenWidth() { return GetDeviceCaps(GetDC(IntPtr.Zero), 8); }
	public static int GetScalingFactor() { return GetDeviceCaps(GetDC(IntPtr.Zero), 88); }
}
"@

if ($window.Height -gt 60) { $window.SizeToContent = 'Height' }
$scalingDecimal = [Display]::GetScalingFactor()/ 96
$effectiveVertRes = ([double][Display]::GetScreenHeight()/ $scalingDecimal)
$effectiveHorizRes = ([double][Display]::GetScreenWidth()/ $scalingDecimal)
$window.MaxHeight = 0.4 * $effectiveVertRes
$window.MaxWidth = 0.4 * $effectiveHorizRes

$window.ShowDialog()
Unregister-Event -SourceIdentifier $dgNotesRowEditEvent.Name