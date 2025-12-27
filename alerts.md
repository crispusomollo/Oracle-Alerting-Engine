# 🚨 Alert Definitions

This document describes all alerts implemented in the Alerting Engine.
It mirrors `alert_config.yaml` in a human-readable format.

---

## ALERT-CPU-001 — High CPU Utilization

**Metric:** Host CPU Utilization (%)  
**Threshold:** > 90% for 5 minutes  
**Severity:** CRITICAL  

### Trigger Condition
CPU utilization exceeds threshold across consecutive samples.

### Action
- Log alert
- Create incident
- Trigger DBMS_SCHEDULER remediation chain

### Possible Causes
- Runaway SQL
- Missing indexes
- Inefficient execution plans

---

## ALERT-LOCK-002 — Blocking Sessions Detected

**Metric:** Blocking Sessions Count  
**Threshold:** ≥ 1 blocker for > 2 minutes  
**Severity:** HIGH  

### Trigger Condition
One or more sessions blocking others.

### Action
- Log alert
- Create incident
- Notify DBA (manual remediation preferred)

### Possible Causes
- Long-running transactions
- Uncommitted DML
- Application design issues

