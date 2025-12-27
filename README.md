# 🚨 Oracle Alerting Engine

A **rule-driven alerting engine** that evaluates Oracle performance metrics, detects incidents, and triggers automated or manual remediation workflows.

This repository sits at the **decision point** of the Oracle DBA Automation Series, translating raw monitoring data into **actionable incidents**.

---

## 🎯 Purpose

The Alerting Engine is responsible for:

* Evaluating performance metrics against defined thresholds
* Creating auditable incident records
* Triggering DBMS_SCHEDULER automation when safe
* Providing a governance layer between monitoring and remediation

It ensures the system **acts deliberately**, not reactively.

---

## 🧭 How It Fits in the Series

```
Performance Monitoring Pipeline
            ↓
       Alerting Engine   ← (this repo)
            ↓
     INCIDENTS (RCA)
            ↓
DBMS_SCHEDULER Automation
            ↓
Indexing / Partitioning / Resource Manager
```

Monitoring collects data.
**This engine decides what matters.**

---

## 📁 Repository Structure

```text
alerting_engine/
│
├── README.md
├── alert_config.yaml        # Thresholds and alert rules
├── alert_runner.py          # Core evaluation engine
├── notify.py                # Notification abstraction
│
├── alerts.md                # Human-readable alert catalogue
├── INCIDENT_POLICY.md       # Alert → action governance
│
├── incidents/               # Real incident reports
│   ├── INC-2025-10-24-DB-LOCK-001.md
│   └── INC-2025-11-02-DB-CPU-002.md
│
├── logs/
│   └── alert_logs_YYYYMMDD.log
│
├── tests/                   # Safe alert simulations
│   ├── test_cpu_alert.json
│   ├── test_lock_alert.json
│   └── run_tests.py
│
└── utils/
    ├── metrics_parser.py
    └── sql_helpers.py
```

---

## 🔍 Alert Configuration

### `alert_config.yaml`

Defines all alert rules declaratively.

Example:

```yaml
alerts:
  cpu_high:
    id: ALERT-CPU-001
    metric: cpu_utilization
    threshold: 90
    duration_minutes: 5
    severity: CRITICAL
    auto_remediate: true
    scheduler_action: JOB_CHAIN_RUNAWAY_SQL_REMEDIATION
```

This separation allows alert tuning **without changing code**.

---

## ⚙️ How It Works

1. Metrics are received from the monitoring pipeline (JSON or stdin)
2. `alert_runner.py` evaluates metrics against `alert_config.yaml`
3. If breached:

   * Alert is logged
   * Incident file is created
   * Notification is sent
4. If permitted:

   * DBMS_SCHEDULER job or chain is triggered
5. All actions are logged for audit and RCA

---

## 🚨 Incidents & RCA

Each alert creates a **real incident document** under `incidents/`.

Incidents include:

* Detection time
* Metric details
* Immediate actions
* Resolution status
* Lessons learned

See:

* `INC-2025-10-24-DB-LOCK-001.md`
* `INC-2025-11-02-DB-CPU-002.md`

📘 Full index available in `INCIDENTS.md` at the series root.

---

## 🛡️ Incident Governance

### `INCIDENT_POLICY.md`

Defines:

* Alert severity levels
* When automation is allowed
* When manual intervention is required
* Escalation rules

This prevents unsafe auto-remediation and reflects **production discipline**.

---

## 🧪 Testing & Simulation

The `tests/` directory allows safe validation without Oracle access.

Example:

```bash
python3 tests/run_tests.py
```

This simulates alerts using sample metric payloads and validates logic deterministically.

---

## 🔔 Notifications

### `notify.py`

Provides a clean abstraction for:

* Email
* Slack
* PagerDuty (future)

Currently implemented as a stub to keep the repo vendor-neutral.

---

## 🔗 Integration with DBMS_SCHEDULER

When auto-remediation is enabled, alerts trigger Oracle automation using:

* DBMS_SCHEDULER jobs
* DBMS_SCHEDULER job chains
* Maintenance windows (governed execution)

This ensures **Oracle remains the execution authority**, not external scripts.

---

## 🧠 What This Repo Demonstrates

* Separation of monitoring and decision logic
* Rule-based alert evaluation
* Incident-driven operations
* Safe automation boundaries
* Audit-ready alerting workflows
* Production-style documentation

This is **how real DBA teams operate**, not demo alerting.

---

## 🔮 Future Enhancements

* Alert suppression windows
* Alert deduplication / debounce logic
* Incident closure workflows
* Notification channel integrations
* Centralized alert dashboard

---

## 🔗 Related Repositories

* Performance Monitoring Pipeline
* DBMS_SCHEDULER Automation
* Session & Lock Monitoring
* Indexing Strategy
* Partitioning Strategy

Together, they form a **complete Oracle DBA operating model**.

