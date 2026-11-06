# BAD CODE: Race Condition
class Counter:
    def __init__(self):
        self.value = 0
    
    def increment(self):
        # BUG: Read-modify-write without a lock
        current = self.value
        self.value = current + 1