##License Assignment for users based on their displayname

$user = 'devendra.pindiyar@maxlifeinsurance.com'
#$cred = Get-Credential -Credential $user

#Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File E:\cred.txt

#$cred.Password | ConvertFrom-SecureString | Out-File "E:\credc.txt"
#$cred.Password | ConvertTo-SecureString | Out-File E:\cred.txt
$pass = cat E:\credc.txt | ConvertTo-SecureString 
$mycred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass
Connect-MsolService -Credential $mycred
Get-MsolAccountSku

$file = Import-Csv "C:\Users\abhi\Desktop\test.csv"

$file | ForEach-Object{
    Set-MsolUser -UserPrincipalName $_.userprincipalname -UsageLocation IN
    if ((Get-MsolUser -UserPrincipalName $_.userprincipalname).displayname -like '*(BP)*') {
        Set-MsolUserLicense -UserPrincipalName $_.userprincipalname -AddLicenses '#LicensesNameforMaxlifeUsers'
    }
    else {
        Set-MsolUserLicense -UserPrincipalName $_.userprincipalname -AddLicenses '#LicensenameforMaxlifeUsers'
    }
}
