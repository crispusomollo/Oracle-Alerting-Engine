import json
import sys

def parse_metric(file=None):
    """
    Accepts JSON input from monitoring pipeline or test files
    """
    if file:
        with open(file) as f:
            return json.load(f)

    # stdin support (pipeline integration)
    data = sys.stdin.read()
    return json.loads(data)

