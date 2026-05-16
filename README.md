# Work Device Security Monitoring

A transparent, employee-friendly device monitoring solution for company-issued Android devices. This system helps protect sensitive data in secure environments while maintaining employee privacy.

## Features

- **Transparent Monitoring**: Employees can see what's being monitored in real-time
- **Work-Only Focus**: Monitors work-related activity only
- **Device Enrollment**: Simple setup via MDM or manual installation
- **Real-time Alerts**: Notifies administrators of security events
- **Audit Logs**: Complete history of monitoring actions
- **Employee Dashboard**: Workers can view their own device status

## What Gets Monitored

### ✅ Work-Related Activity
- Work file access (documents, spreadsheets, presentations)
- USB device connections
- External storage access
- Work application installations
- Network connections to non-work IPs
- Screenshot/screen capture attempts on work apps
- Location logs during work hours

### ❌ NOT Monitored
- Personal messaging (SMS, WhatsApp, personal email)
- Web browsing (unless accessing company systems)
- App usage outside work hours
- Call logs
- Calendar/personal notes
- Any data marked as personal

## Architecture

```
┌─────────────────────────────────────────────────┐
│   Android Devices (15 work phones)              │
│   ├─ Device Agent App (installed)               │
│   └─ Reports to backend every 15 min            │
└──────────────┬──────────────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────────────┐
│   Backend Server (Your Infrastructure)          │
│   ├─ API Endpoint: /api/device-reports         │
│   ├─ Database: Device logs & events            │
│   └─ Alert System: Notifies on suspicious activity
└──────────────┬──────────────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────────────┐
│   Admin Dashboard                               │
│   ├─ View all devices & status                 │
│   ├─ Review security events                    │
│   └─ Generate compliance reports               │
└─────────────────────────────────────────────────┘
```

## Quick Start

### For Administrators

1. **Set up backend server** (see `/server` directory)
2. **Configure device enrollment** via MDM or QR code
3. **Share employee policy** with workers
4. **Launch admin dashboard**

### For Employees

1. **Receive notification** about monitoring policy
2. **Install app** from work app store or via MDM
3. **View monitoring status** in app settings
4. **Access personal dashboard** to see what's monitored

## Legal Requirements

⚠️ **Before deployment, you MUST:**

- [ ] Consult employment lawyer in your jurisdiction
- [ ] Create written "Device Monitoring Policy"
- [ ] Have all employees sign acknowledgment form
- [ ] Ensure policy complies with:
  - Local employment laws (GDPR, CCPA, state laws, etc.)
  - Union agreements (if applicable)
  - Industry regulations (healthcare, finance, etc.)
- [ ] Keep audit logs of who accessed what data
- [ ] Establish escalation process for data access
- [ ] Define data retention period

### Sample Employee Notification

> "Company-issued devices are monitored for security purposes. Monitoring includes work files, USB connections, and external storage access during work hours. Personal data and off-hours activity are not monitored. Employees can request audit logs of their device at any time. By accepting this device, you acknowledge and consent to this monitoring."

## Directory Structure

```
├── README.md                    # This file
├── LICENSE                      # Apache 2.0
├── android-agent/               # Android app source code
│   ├── app/
│   ├── build.gradle
│   └── AndroidManifest.xml
├── server/                      # Backend API & database
│   ├── api/
│   ├── database/
│   ├── requirements.txt
│   └── config.example.env
├── docs/
│   ├── EMPLOYEE_POLICY.md      # What to share with workers
│   ├── SETUP_GUIDE.md          # Deployment instructions
│   └── API_REFERENCE.md        # Backend API docs
└── scripts/
    ├── setup-device.sh         # Device enrollment script
    └── setup-server.sh         # Server initialization
```

## Next Steps

1. Review `/docs/EMPLOYEE_POLICY.md`
2. Consult your legal team
3. Set up backend server (see `/server/README.md`)
4. Build and test Android app
5. Deploy via MDM to first device
6. Gather employee feedback
7. Roll out to all 15 devices

## Support

For issues or questions:
- Create an issue in this repository
- Contact your security team
- Review API documentation in `/docs/API_REFERENCE.md`

## License

Apache License 2.0 - See LICENSE file
