$param (
	[string]$webApp = $(throw "-webApp is required. Use the name, not the web app url."),
	[string]$Url = $(throw "-Url is required."),
	[string]$protocol = "https",
	[int]$Port = 443
	[bool]$Ssl = $true
)

if (($Ssl -eq $true) -or ($protocol -eq "https")){ 
New-WebBinding -Name "$($webApp)" -Force -HostHeader "$($Url)" -Port "443" -Protocol "https" -sslFlags 1
}
else {
New-WebBinding -Name "$($webApp)" -Force -HostHeader "$($Url) -Port $Port -Protocol $Protocol -sslFlags 0 
}
