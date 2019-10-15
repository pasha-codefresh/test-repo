ROOTPATH) {
    $analyzeParams.Path = Join-Path '/github/workspace' $env:INPUT_ROOTPATH
} else {
    $analyzeParams.Path = $env:GITHUB_WORKSPACE
}

# Path to custom script analzyer settings
if ($env:INPUT_SETTINGSPATH) {
    $analyzeParams.Settings = Join-Path '/github/workspace' $env:INPUT_SETTINGSPATH
}

# Run PSScriptAnalyzer
$issues   = Invoke-ScriptAnalyzer @analyzeParams
$errors   = $issues.Where({$_.Severity -eq 'Error'})
$warnings = $issues.Where({$_.Severity -eq 'Warning'})
$infos    = $issues.Where({$_.Severity -eq 'Information'})

# Create comment string
$comment  = '**PSScriptAnalyzer results:**'
$comment += '{0}<details><summary>Errors: [{1}], Warnings: [{2}], Information: [{3}]</summary><p>{4}{5}```' -f $nl, $errors.Count, $warnings.Count, $infos.Count, $nl, $nl
if ($errors.Count -gt 0) {
    $comment += $nl + ($errors | Format-List -Property RuleName, Severity, ScriptName, Line, Message | Out-String -Width 80).Trim()
}
if ($warnings.Count -gt 0) {
    $comment += $nl+ $nl + ($warnings | Format-List -Property RuleName, Severity, ScriptName, Line, Message | Out-String -Width 80).Trim()
}
if ($infos.Count -gt 0) {
    $comment += $nl + $nl + ($infos | Format-List -Property RuleName, Severity, ScriptNam
