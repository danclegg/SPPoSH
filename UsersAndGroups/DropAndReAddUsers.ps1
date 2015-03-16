param (
	[string]$Url = (throw "-Url is required")
)

$web = Get-SPWeb $Url

$users = Get-SPUser -Web $web |Select UserLogin,Roles,DisplayName
$group = $web.AssociatedMemberGroup
foreach($user in $users)
{
	$netId = $user.UserLogin
	$roles = $user.Roles
	$name = $user.DisplayName
	$web | Remove-SPUser -Identity $netId -Confirm:$false
	$web | New-SPUser -UserAlias $netId -DisplayName $name -Group $group
	foreach ($role in $roles){
		$web | Set-SPUser -AddPermissionLevel $role -ErrorAction Continue
	}	
}
$web.Dispose()
$site.Dispose()