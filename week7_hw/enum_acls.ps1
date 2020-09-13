$directory = Get-Location
$list = Get-ChildItem

foreach ($item in $directory) {
    
    Get-Acl $item
}