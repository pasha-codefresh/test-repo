# By default, run PSScriptAnalyzer on the whole repository
# but allow overriding this with INPUT_ROOTPATH environment variable
if ($env:INPUT_ROOTPATH) {
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
