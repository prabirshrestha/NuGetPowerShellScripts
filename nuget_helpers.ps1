#param($rootPath, $toolsPath, $package, $project)
# $project = Get-Project ConsoleApplication1

	function Get-TargetFrameworkMoniker($project){
		#  $monkier samples
		# 
		# .NETFramework,Version=v4.0
		# .NETFramework,Version=v4.0,Profile=Client
		# .NETFramework,Version=v3.5,Profile=Client
		# .NETFramework,Version=v3.5
		# .NETFramework,Version=v3.0
		# .NETFramework,Version=v2.0
		#  Silverlight,Version=v4.0
		#  Silverlight,Version=v4.0,Profile=WindowsPhone
		# 
		return $project.Properties.Item("TargetFrameworkMoniker").Value
	}

	function Get-FrameworkName($monkier){
		# 
		# Identifier     Version     Profile		FullName                                    
		# ----------     -------     -------		--------                                    
		# .NETFramework  2.0						.NETFramework,Version=v2.0  
		# .NETFramework  4.0         Client			.NETFramework,Version=v4.0,Profile=Client 
		# Silverlight    4.0						Silverlight,Version=v4.0        
		# Silverlight    4.0         WindowsPhone	Silverlight,Version=v4.0,Profile=WindowsPhone
		# 
		return new-object System.Runtime.Versioning.FrameworkName($monkier)
	}

	function Is-ClientProile($frameworkName){
		return $frameworkName.Profile -eq "Client"
	}

	function Is-Silverlight($frameworkName){
		return $frameworkName.Identifier -eq "Silverlight"
	}

	function Is-WindowsPhone($frameworkName){
		return $frameworkName.Profile -eq "WindowsPhone"
	}

	function Get-ProjectReferences($project){
		return $project.Object.References
	}

	function Add-ProjectReference($project, $dllName){
		$project.Object.References.Add($dllName)
	}

	function Remove-ProjectReference($project, $dllName){
		$project.Object.References | Where-Object { $_.Name -eq $dllName } | ForEach-Object { $_.Remove() }
	}

	function Get-ProjectDir($project){
		return [System.IO.Path]::GetDirectoryName($project.FullName)
	}

	function DteBrowserNavigate($project,$url){
		# open the browser inside visual studio and navigate to the specified url.
		$project.DTE.ItemOperations.Navigate($url)  
	}