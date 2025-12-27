# 🚦 Incident Response Policy

This document defines how alerts are handled and escalated.

---

## Alert Handling Levels

### Informational
- Logged only
- No incident created

### Warning
- Incident created
- No automatic remediation

### Critical
- Incident created
- Automated remediation allowed
- DBA notification required

---

## Automation Rules

| Alert Type | Auto-Remediation | Notes |
|----------|------------------|------|
| CPU Saturation | Yes | Index review + validation |
| Blocking Locks | No | Manual verification required |
| I/O Waits | Conditional | Depends on duration |

---

## Escalation

- Repeated alerts within 24h → severity upgrade
- Failed remediation → manual DBA intervention

