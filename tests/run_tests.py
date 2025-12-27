from utils.metrics_parser import parse_metric
from alert_runner import evaluate_alert

def run_test(file):
    metric = parse_metric(file)
    result = evaluate_alert(metric)
    print(f"{file}: {result}")

run_test("test_cpu_alert.json")
run_test("test_lock_alert.json")

