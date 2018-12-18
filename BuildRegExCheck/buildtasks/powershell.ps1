[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
try {
    # Get inputs.
    $checkExpression = Get-VstsInput -Name 'checkString' -Require
    $directory = Get-VstsInput -Name 'rootDirectory' -Require
    $fileNameRegEx = Get-VstsInput -Name 'fileName'
    $targetMatches = Get-VstsInput -Name 'expectedMatches' -Require

    $matchedFiles = New-Object System.Collections.Generic.List[System.String]

    Write-Host "Check string is: $checkExpression"

    #$matchedFiles = Get-ChildItem $directory -recurse | Select-String -pattern "$input" | group path | select name

    Get-ChildItem $directory -recurse | Where { !$_.PSIsContainer } | Foreach-Object {
        if (![string]::IsNullOrEmpty($fileNameRegEx) -and ![regex]::ismatch($_.FullName, $fileNameRegEx))
        {
            # File is excluded due to file name regular expression
            continue
        }

        $fileContent = [System.IO.File]::ReadAlltext($_.FullName)

        if (![string]::IsNullOrEmpty($fileContent) -and [regex]::ismatch($fileContent, $checkExpression))
        {
            $matchedFiles.Add($_.FullName)
        }
    }

    $fileCount = $matchedFiles.Count

    if ($fileCount -ne $targetMatches)
    {        
        ForEach ($element in $matchedFiles) {
	        Write-Host $element
        }
        
        Write-Error "Found $fileCount matching items, expected $targetMatches."
    }
    else
    {
        Write-Host "Found $fileCount matching items as expected."
    }

} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}