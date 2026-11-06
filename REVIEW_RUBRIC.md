# AI Code Review Rubric

When auditing AI-generated code, evaluate it on these 4 pillars:

## 1. Security (Critical)
- Are there hardcoded secrets (passwords, API keys)?
- Is SQL parameterized? (Look for f-strings in SQL).
- Are user inputs sanitized before hitting OS commands (os.system, subprocess)?
- Is eval() or exec() used?

## 2. Concurrency (High)
- Are shared resources (counters, lists) protected by a Lock?
- Is there a risk of deadlock (multiple locks acquired in different orders)?
- Are threads daemonized properly?

## 3. Performance (Medium)
- Are there N+1 database queries inside a loop?
- Is memory usage unbounded (e.g., loading a huge file into RAM)?
- Are there missing timeouts on external HTTP requests?

## 4. Correctness & Edge Cases (High)
- Does it handle empty inputs?
- Are exceptions caught and handled (or do they crash the app)?
- Are off-by-one errors present in loops?