import yaml
import datetime
from utils.metrics_parser import parse_metric
from utils.sql_helpers import run_scheduler_job
from notify import notify
from pathlib import Path

CONFIG_FILE = "alert_config.yaml"
LOG_DIR = Path("logs")
INCIDENT_DIR = Path("incidents")

LOG_DIR.mkdir(exist_ok=True)
INCIDENT_DIR.mkdir(exist_ok=True)

def load_config():
    with open(CONFIG_FILE) as f:
        return yaml.safe_load(f)["alerts"]

def log(message):
    log_file = LOG_DIR / f"alert_logs_{datetime.date.today()}.log"
    with open(log_file, "a") as f:
        f.write(f"{datetime.datetime.now()} | {message}\n")

def create_incident(alert_id, metric, value):
    incident_id = f"INC-{datetime.date.today()}-{alert_id}"
    file_path = INCIDENT_DIR / f"{incident_id}.md"

    with open(file_path, "w") as f:
        f.write(f"""# 🚨 Incident {incident_id}

**Alert ID:** {alert_id}  
**Metric:** {metric}  
**Value:** {value}  
**Detected At:** {datetime.datetime.now()}

## Summary
Threshold breach detected by alerting engine.

## Immediate Actions
- Alert logged
- DBA notified

## Status
OPEN
""")
    return incident_id

def evaluate_alert(metric_data):
    alerts = load_config()
    metric = metric_data["metric"]
    value = metric_data["value"]

    for rule in alerts.values():
        if rule["metric"] == metric and value >= rule["threshold"]:
            log(f"ALERT TRIGGERED: {rule['id']} value={value}")

            incident_id = create_incident(rule["id"], metric, value)
            notify(rule["severity"], rule["id"], value, incident_id)

            if rule["auto_remediate"]:
                run_scheduler_job(rule["scheduler_action"])
                log(f"AUTO-REMEDIATION TRIGGERED: {rule['scheduler_action']}")

            return "ALERT_TRIGGERED"

    return "OK"

if __name__ == "__main__":
    metric = parse_metric()
    evaluate_alert(metric)

