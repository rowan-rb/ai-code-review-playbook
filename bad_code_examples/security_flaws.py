# BAD CODE: SQL Injection & Command Injection
import os
import sqlite3

def get_user(user_id):
    conn = sqlite3.connect("users.db")
    cursor = conn.cursor()
    # BUG: f-string SQL Injection
    query = f"SELECT * FROM users WHERE id = '{user_id}'"
    cursor.execute(query)
    return cursor.fetchone()

def ping_host(host):
    # BUG: OS Command Injection
    os.system(f"ping -c 1 {host}")