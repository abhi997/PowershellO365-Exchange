$user = 'devendra.pindiyar@maxlifeinsurance.com'

$pass = cat E:\credc.txt | ConvertTo-SecureString 
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass

$session = New-PSSession -ConfigurationName microsoft.exchange -ConnectionUri https://outlook.office365.com/powershell-liveid -Authentication Basic -AllowRedirection -Credential $cred
Import-PSSession $session

$date = Get-Date -Format D  

$a = 1..150
foreach($a in 1..150){
    Get-MessageTrace -PageSize 50 |Select-Object received, senderAddress, RecipientAddress, Subject | Export-Csv "F:\$date.csv" -Append
}

Copy-Item -Path "F:\$date.csv" -Destination E:\danesh\unix 
Remove-Item -Path "F:\$date.csv'" 
