# Review: race_condition.py

## Issues Found
1. **Concurrency (Race Condition):** The increment method is not atomic. If two threads call it simultaneously, both can read the same current value, increment it, and overwrite each other. This results in lost updates.
2. **Code Quality:** self.value += 1 is cleaner and more Pythonic.

## How to Fix
Use a threading.Lock to ensure mutual exclusion around the critical section.

```python
import threading

class Counter:
    def __init__(self):
        self.value = 0
        self.lock = threading.Lock()

    def increment(self):
        with self.lock:
            self.value += 1
```
