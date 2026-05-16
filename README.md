# Device Security Monitor - Transparent Monitoring Solution

A transparent, consent-based security monitoring system for corporate Android work devices.

## Overview

This system allows organizations to monitor company-provided work devices for security threats while maintaining employee transparency and legal compliance.

**Key Features:**
- ✅ Transparent monitoring (employees know they're monitored)
- ✅ Consent-based (requires written agreement)
- ✅ Work-focused data collection only
- ✅ Real-time alerts for suspicious activity
- ✅ Device enrollment management
- ✅ Audit logging
- ✅ Admin dashboard

## Architecture

```
┌─────────────────────────────────────────────────┐
│  Android Work Devices (15x)                     │
│  ├── Device Security Agent (APK)                │
│  ├── Monitors: WiFi, USB, Apps, Files Access   │
│  └── Reports to Backend API                     │
└──────────────────┬──────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────┐
│  Backend API Server (Your Infrastructure)       │
│  ├── Device enrollment management               │
│  ├── Receives monitoring reports                │
│  ├── Stores in database                         │
│  ├── Processes alerts                           │
│  └── Serves admin dashboard                     │
└──────────────────┬──────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────┐
│  Admin Dashboard                                │
│  ├── Real-time device status                    │
│  ├── Security alerts                            │
│  ├── Device activity logs                       │
│  ├── User management                            │
│  └── Reports                                    │
└─────────────────────────────────────────────────┘
```

## Data Collected (Work-Related Only)

### Device Monitoring
- Device ID, OS version, installed apps list
- Network connections (IPs, domains, ports)
- USB device connections
- File access logs (work folders only)
- Unusual process activity
- Screen timeout events

### Security Alerts
- Unauthorized app installations
- Suspicious network activity
- Multiple failed unlock attempts
- USB data transfer attempts
- Unencrypted data transmission

## Compliance & Legal

⚠️ **CRITICAL: Before deployment, you MUST:**

1. ✅ Consult an employment lawyer in your jurisdiction
2. ✅ Create an employee monitoring policy
3. ✅ Obtain written consent from all employees
4. ✅ Ensure GDPR/CCPA compliance (if applicable)
5. ✅ Document retention policies
6. ✅ Provide opt-out procedures

See `docs/LEGAL.md` for detailed requirements.

## Setup Instructions

### Prerequisites
- Node.js 16+ (for backend)
- Android Studio (for agent app)
- Database: PostgreSQL/MySQL
- Server: Linux/Windows with Node.js support

### Quick Start

1. **Backend Setup**
   ```bash
   cd backend-api
   npm install
   cp .env.example .env
   # Configure database and API keys
   npm run migrate
   npm start
   ```

2. **Android Agent Build**
   ```bash
   cd android-agent
   ./gradlew build
   # Sign APK with your keystore
   ./gradlew assembleRelease
   ```

3. **Deploy to Devices**
   - Use MDM solution (Samsung Knox, Google Workspace, Intune) OR
   - Manual installation via ADB

See `docs/DEPLOYMENT.md` for detailed steps.

## Transparency Requirements

This system **must** operate transparently:

- ✅ Employees must KNOW they're being monitored
- ✅ Clear signs in workplace about monitoring
- ✅ Written policy accessible to all employees
- ✅ Regular training on monitoring scope
- ✅ Monthly reports available to employees
- ✅ Opt-out procedure (if applicable by law)
- ✅ Data retention limits (recommend 90 days)

## License

Apache License 2.0 - See LICENSE file

---

**⚠️ DISCLAIMER:** This tool is designed for transparent, consensual workplace monitoring. Unauthorized use or monitoring without consent may violate local, state, or federal laws.