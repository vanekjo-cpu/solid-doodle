# Employee Device Enrollment Checklist

## Pre-Enrollment (Admin)

### Legal & HR
- [ ] Legal review completed
- [ ] Employee monitoring policy created
- [ ] Privacy policy created
- [ ] Enrollment agreement prepared
- [ ] HR approval obtained
- [ ] Employee training scheduled

### Google Workspace Setup
- [ ] Google Workspace account created for employee
- [ ] Employee account activated (wait 24 hours)
- [ ] Enrollment token created for employee
- [ ] Token securely distributed
- [ ] Enrollment deadline communicated
- [ ] Technical support contact provided

### Device Preparation
- [ ] Android device purchased/allocated
- [ ] Device model compatible (Android 10+)
- [ ] Device factory reset
- [ ] SIM card installed (if needed)
- [ ] Device assigned serial number
- [ ] Device documented in inventory

### Backend Setup
- [ ] Monitoring backend deployed
- [ ] Database initialized
- [ ] API endpoints tested
- [ ] Authentication configured
- [ ] Encryption enabled
- [ ] Audit logging active

## Pre-Enrollment (Employee)

### Training & Acknowledgment
- [ ] Employee read monitoring policy
- [ ] Employee read privacy policy
- [ ] Employee asked questions
- [ ] Employee signed consent form
- [ ] Signed form filed in HR
- [ ] Employee received training materials
- [ ] Employee completed training quiz (optional)
- [ ] Employee confirmed understanding

### Preparation
- [ ] Employee received device
- [ ] Employee received enrollment token (securely)
- [ ] Employee has WiFi access during setup
- [ ] Employee knows IT support contact
- [ ] Employee knows setup deadline
- [ ] Employee has time for setup (1 hour required)

## Enrollment Day (Employee Steps)

### Step 1: Power On Device
- [ ] Device powered on
- [ ] Initial language/region selected
- [ ] Connected to WiFi

### Step 2: Google Account Setup
- [ ] "Set up for work" selected (if available)
- [ ] Company email entered: firstname.lastname@company.com
- [ ] Google Workspace login completed
- [ ] Two-factor authentication passed (if enabled)

### Step 3: MDM Enrollment
- [ ] Enrollment prompt appeared
- [ ] Enrollment token entered correctly
- [ ] Device management permissions accepted
- [ ] "Accept" clicked on MDM enrollment screen
- [ ] Device name entered/confirmed

### Step 4: Policy Application
- [ ] Device downloading security policy (wait 5-10 minutes)
- [ ] Lock screen setup completed
- [ ] Strong password created (8+ chars, mixed case, numbers, symbols)
- [ ] Fingerprint registered (optional)
- [ ] Device rebooted (if required)

### Step 5: App Installation
- [ ] Google Play becomes accessible
- [ ] Device Security Monitor app appears
- [ ] App installation completes automatically
- [ ] App opens successfully
- [ ] No installation errors

### Step 6: Verification
- [ ] Settings → Security → Device Administrators
  - [ ] "[Company] Mobile Device Management" listed
  - [ ] "Device Security Monitor" present
- [ ] Lock screen enabled and secured
- [ ] Device encryption enabled
- [ ] USB debugging disabled
- [ ] Unknown sources disabled

### Step 7: Final Confirmation
- [ ] Device Security Monitor shows "Device: Online"
- [ ] No error messages
- [ ] Device model correctly identified
- [ ] Battery charging normally
- [ ] WiFi connected
- [ ] All apps functioning

## Post-Enrollment (Admin Verification)

### Check Admin Console

```bash
admin.google.com → Devices and data → Android
```

- [ ] Device appears in list
- [ ] Device shows: Compliant: ✓
- [ ] Device shows: Policy: "Work Devices - Monitoring"
- [ ] Device shows: Last sync: Within last hour
- [ ] No compliance violations
- [ ] App Status: Installed

### Check Backend Dashboard

```bash
https://dashboard.yourcompany.com
```

- [ ] Device appears online
- [ ] Device reports flowing in
- [ ] No connection errors
- [ ] Device data visible
- [ ] Monitoring active
- [ ] Last report: Within last 30 minutes

### Hardware Verification

- [ ] Device physically present
- [ ] Device model correct
- [ ] Serial number matches record
- [ ] Device assignment documented
- [ ] Employee signed receipt
- [ ] Device tracking number assigned

## Post-Enrollment (Employee)

### First Use
- [ ] Employee powered on device
- [ ] Employee set up email (if desired)
- [ ] Employee explored basic apps
- [ ] Employee reported no issues
- [ ] Employee knows how to add company apps
- [ ] Employee knows how to contact support

### Understanding
- [ ] Employee understands they're monitored
- [ ] Employee knows what's monitored (work data)
- [ ] Employee knows what's NOT monitored (personal files)
- [ ] Employee knows how to request their data
- [ ] Employee knows complaint process
- [ ] Employee feels comfortable with device

## Troubleshooting During Enrollment

### Device Won't Connect to WiFi
- [ ] WiFi password verified
- [ ] WiFi signal strong
- [ ] Other devices can connect (test with admin phone)
- [ ] Airplane mode disabled
- [ ] Try "forget" and reconnect
- [ ] Factory reset if needed

### Enrollment Token Invalid
- [ ] Token not expired (check admin console)
- [ ] Token entered exactly (copy/paste if available)
- [ ] Token for correct organizational unit
- [ ] Create new token if old one expired
- [ ] Verify token typed without spaces

### Google Account Not Recognized
- [ ] Wait 24 hours for account to propagate
- [ ] Verify email address is correct
- [ ] Check employee account created in Workspace
- [ ] Check employee account activated
- [ ] Try with different WiFi
- [ ] Contact Google Workspace support

### MDM Policy Won't Apply
- [ ] Device rebooting (wait 5+ minutes)
- [ ] Strong WiFi connection required
- [ ] Check admin console for policy
- [ ] Force policy sync: Settings → Google → Device Management → [Company]
- [ ] Remove and re-enroll device if persistent

### App Won't Install
- [ ] Wait 24 hours for app to publish in Managed Play
- [ ] Device must be compliant with policy first
- [ ] Check storage (must have 500MB+ free)
- [ ] Check battery (must be 15%+)
- [ ] Clear Google Play cache: Settings → Apps → Google Play Store → Storage → Clear Cache
- [ ] Restart device
- [ ] Try manual installation via admin console

### Device Shows Non-Compliant
Check admin console for violation:
- [ ] Set lock screen → Settings → Security → Screen lock
- [ ] Weak password → Settings → Security → Password
- [ ] USB debugging on → Settings → Developer Options → USB Debugging OFF
- [ ] Unknown sources enabled → Settings → Security → Unknown Sources OFF
- [ ] Device encryption off → Settings → Security → Encrypt Device

Fix issue then device auto-updates to Compliant status (1-24 hours)

## Sign-Off

### Employee Enrollment Complete

```
Employee Name: ________________________________
Employee ID: ________________________________
Device Model: ________________________________
Device Serial: ________________________________
Enrollment Date: ________________________________
Compliance Status: [ ] Compliant  [ ] Non-Compliant

Employee Signature: _________________________ Date: _____

IT Verification: _________________________ Date: _____
```

## Ongoing Support

### First Week
- [ ] Check-in email (Day 1)
- [ ] Phone call to check all working (Day 3)
- [ ] Answer any questions
- [ ] Provide support contact info
- [ ] Verify device still compliant

### First Month
- [ ] Follow-up email (Day 15)
- [ ] Verify monitoring data flowing
- [ ] Check for compliance issues
- [ ] Gather employee feedback
- [ ] Offer additional training if needed

### Ongoing
- [ ] Monthly compliance checks
- [ ] Quarterly device audits
- [ ] Semi-annual policy review
- [ ] Annual security assessment

---

**Keep this checklist for each employee in compliance records**
