Write-Host "Starting Review Playbook Verification..." -ForegroundColor Cyan

$fail = 0
$expected_files = @(
    "README.md",
    "REVIEW_RUBRIC.md",
    "bad_code_examples\race_condition.py",
    "bad_code_examples\security_flaws.py",
    "my_reviews\review_race_condition.md",
    "my_reviews\review_security_flaws.md"
)

Write-Host "`n[1] Checking that all files exist..." -ForegroundColor Yellow
foreach ($file in $expected_files) {
    if (Test-Path $file) {
        Write-Host "  [OK] $file" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $file" -ForegroundColor Red
        $fail++
    }
}

Write-Host "`n[2] Checking that the content is valid..." -ForegroundColor Yellow
$rubric_content = Get-Content "REVIEW_RUBRIC.md" -Raw
if ($rubric_content -match "Security" -and $rubric_content -match "Concurrency") {
    Write-Host "  [OK] The rubric contains the Security and Concurrency pillars." -ForegroundColor Green
} else {
    Write-Host "  [FAIL] The rubric is incomplete." -ForegroundColor Red
    $fail++
}

Write-Host "`n[3] Checking that the code examples are vulnerable..." -ForegroundColor Yellow
$bad_code = Get-Content "bad_code_examples\security_flaws.py" -Raw
if ($bad_code -match "os.system" -and $bad_code -match "cursor.execute") {
    Write-Host "  [OK] The examples contain real vulnerabilities." -ForegroundColor Green
} else {
    Write-Host "  [FAIL] The examples do not contain the expected vulnerabilities." -ForegroundColor Red
    $fail++
}

Write-Host "`n--- SUMMARY ---" -ForegroundColor Cyan
if ($fail -eq 0) {
    Write-Host "TODO OK: The Review Playbook is complete and ready for the interview." -ForegroundColor Green
} else {
    Write-Host "$fail failures found." -ForegroundColor Red
}