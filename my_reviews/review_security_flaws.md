# Review: security_flaws.py

## Issues Found
1. **SQL Injection (Critical):** In get_user(), the user_id is directly interpolated into the SQL query using an f-string. An attacker could pass ' OR 1=1 -- to dump the entire database.
2. **Command Injection (Critical):** In ping_host(), the host is concatenated into the shell command. An attacker could pass google.com; rm -rf / to execute arbitrary system commands.

## How to Fix
1. Use parameterized queries for SQL.
2. Use list-based subprocess calls (without shell=True) for OS commands.

```python
import subprocess
import sqlite3

def get_user(user_id):
    conn = sqlite3.connect("users.db")
    cursor = conn.cursor()
    # FIXED: Parameterized query
    query = "SELECT * FROM users WHERE id = ?"
    cursor.execute(query, (user_id,))
    return cursor.fetchone()

def ping_host(host):
    # FIXED: Safe list argument (no shell execution)
    subprocess.run(["ping", "-c", "1", host])
```
