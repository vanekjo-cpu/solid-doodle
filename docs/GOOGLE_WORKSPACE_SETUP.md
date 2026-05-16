# Google Workspace MDM Setup Guide

## Overview

Google Workspace Mobile Device Management (MDM) allows you to:
- ✅ Auto-enroll Android devices
- ✅ Push APK to all devices automatically
- ✅ Prevent app uninstallation
- ✅ Enforce device policies
- ✅ Remote wipe if needed
- ✅ Track device compliance

## Prerequisites

- [ ] Google Workspace Business Standard or Enterprise account
- [ ] Admin access to Workspace
- [ ] 15 Android devices (Android 10+)
- [ ] WiFi connectivity on all devices
- [ ] Employee consent forms signed

## Step 1: Enable Android Device Management

### 1.1 Go to Google Admin Console

```
https://admin.google.com
Sign in with your admin account
```

### 1.2 Enable Android Management

```
Left menu → Devices and data → Mobile & endpoint management → Settings

Check: "Allow users to enroll Android devices"
Check: "Android Management API"

Click Save
```

### 1.3 Create an Android Enrollment Token

```
Left menu → Devices and data → Mobile & endpoint management → Android

Click "Create enrollment token"

Token Name: "Work Device Monitor"
Expiration: 90 days (recommended)
Device Management Level: "Full management"

Click Create

⚠️ SAVE THIS TOKEN - You'll need it for device enrollment
```

## Step 2: Set Up Managed Google Play

### 2.1 Create Managed Google Play Account

```
Left menu → Devices and data → Mobile & endpoint management → Managed Google Play

Click "Set up Managed Google Play"
```

Google will:
1. Create an organization account in Google Play
2. Link to your Workspace domain
3. Set up app management

### 2.2 Accept Terms

```
Review the terms
Click "Accept"
Click "Complete Setup"
```

⏳ **Wait 24 hours for full activation**

### 2.3 Verify Setup

```
Go back to Managed Google Play section
You should see: "Status: Ready"
```

## Step 3: Upload Your APK to Managed Google Play

### 3.1 Access Play Console

Once Managed Google Play is activated:

```
Go to: https://play.google.com/apps/publish/
Sign in with admin account
```

### 3.2 Create New App

```
Click "Create app"
App name: "Device Security Monitor"
Default language: English
App type: Business app (not consumer)
Acceptable content rating: Acceptable

Click Create
```

### 3.3 Upload APK

```
Left menu → Release → Production

Click "Create new release"

Scroll to "APK uploads"
Click "Choose files"
Select your signed APK: app-release.apk

Wait for upload to complete
```

### 3.4 Fill in App Details

```
App Title: "Device Security Monitor"
Short Description: "Work device security and monitoring"
Full Description:
  "This app monitors your work device for security threats.
   Monitoring is transparent and required for work device use.
   All monitoring aligns with company policy."

Screenshots: [Add 2-3 screenshots showing the app]

Category: Productivity
Content Rating: Everyone
Privacy Policy URL: https://yourcompany.com/privacy

Click "Save"
Click "Review release"
Click "Start rollout to Production"
```

### 3.5 Publish

```
Click "Rollout release"

⏳ Wait 2-4 hours for publication
```

⚠️ **Verify the app appears in Managed Google Play before proceeding**

## Step 4: Configure App Deployment Policy

### 4.1 Go to Android Policies

```
https://admin.google.com
Left menu → Devices and data → Mobile & endpoint management → Android
```

### 4.2 Create Device Policy

```
Click "Create policy"

Policy name: "Work Devices - Monitoring"
Device ownership: Corporate-owned, fully managed
Network access: Company WiFi + Mobile

Click Create
```

### 4.3 Configure App Management

```
In the policy, go to "Apps"

Click "Add app"
Select: "Device Security Monitor" (your app)
Set Installation Type: "Mandatory"
Set to auto-update: Yes
Allow uninstall: NO (critical - prevents employee removal)

Click Add
```

### 4.4 Set Security Requirements

```
In the policy, go to "Security"

Enable:
- [x] Require lock screen
- [x] Require strong password (8+ chars, numbers/symbols)
- [x] Disable USB file transfer
- [x] Require device encryption
- [x] Disable developer options
- [x] Disable installation from unknown sources
- [x] Require Google Play Protect

Click Save
```

### 4.5 Configure Device Settings

```
In the policy, go to "Device"

Settings:
- Screen lock timeout: 5 minutes
- Auto-lock: Enabled
- USB file transfer: Disabled
- Developer options: Hidden
- Factory reset: Disabled (prevents factory reset)
- ADB: Disabled

Click Save
```

### 4.6 Configure Network Settings

```
In the policy, go to "Connectivity"

Settings:
- WiFi: Configured (connect to company WiFi)
- Mobile data: Enabled
- Bluetooth: Allowed (for personal devices only)
- NFC: Disabled

Click Save
```

## Step 5: Assign Policy to Organization Unit

### 5.1 Create Organization Unit for Work Devices

```
https://admin.google.com
Left menu → Directory → Organizational units

Click "Create organizational unit"

Name: "Work Devices"
Description: "Android work devices with monitoring"
Parent OU: Root

Click Create
```

### 5.2 Move Users to OU

```
For each of your 15 employees:

Left menu → Directory → Users
Search for employee
Click employee name
Scroll to "Organizational unit"
Change to "Work Devices"
Click Save
```

### 5.3 Apply Policy to OU

```
Left menu → Devices and data → Mobile & endpoint management → Android

Select your policy: "Work Devices - Monitoring"
Click "Edit"
Go to "Deployment"
Select "Work Devices" OU
Click Apply
```

⏳ **Policy will apply within 24 hours**

## Step 6: Enroll Devices

### 6.1 Prepare Enrollment Instructions

Create a document with:

```
=== WORK DEVICE SETUP INSTRUCTIONS ===

1. IMPORTANT: Your device will be monitored per company policy
   Read and sign the Monitoring Agreement before proceeding

2. Power on your Android device

3. Go through initial setup (WiFi, Google account, etc.)
   - Use company email: your.name@company.com
   - Set a strong password (8+ chars, numbers, symbols)

4. When prompted, sign in with your company Google account

5. Accept the MDM enrollment
   - You may see: "Your device will be managed by [Company]"
   - Click "Accept" or "Continue"

6. Wait for automatic setup
   - Device will download security policy (5-10 minutes)
   - App "Device Security Monitor" will install automatically
   - You may NOT uninstall this app

7. Verify Setup
   - Go to Settings → Security → Device Administrators
   - Confirm: "[Company] Mobile Device Management" is listed
   - Open Device Security Monitor app
   - Confirm device shows "Online"

8. Complete
   - Device is now set up for work use
   - Report any issues to IT: support@company.com

Support Contact: [name] [phone] [email]
```

### 6.2 Enroll Device Step-by-Step

**For each of your 15 employees:**

```
1. Give employee their work Android device (fresh or factory reset)

2. Employee powers on device

3. During initial setup, employee taps "Set up for work"

4. Employee enters their company email:
   your.name@company.com

5. Google Workspace login screen appears
   Employee logs in with company credentials

6. Enrollment token prompt:
   Employee enters the enrollment token you created:
   [YOUR_ENROLLMENT_TOKEN]

7. Review and Accept MDM enrollment
   "This device will be managed by [Company]"
   Click Accept

8. Policy downloads and applies (5-10 minutes)
   Device will reboot if needed

9. App installs automatically
   "Device Security Monitor" appears
   Employee CANNOT uninstall (MDM prevents it)

10. Verify:
    - Settings → Security → Device Administrators
    - Confirm MDM profile exists
    - App shows "Online" status
```

### 6.3 Monitor Enrollment Progress

```
Go to Google Admin Console:
https://admin.google.com
Left menu → Devices and data → Mobile & endpoint management → Android

You'll see a list of enrolled devices:
- Device name
- Device model
- Owner
- Enrollment date
- Policy status
- Last sync time

Wait for all 15 devices to show "Compliant"
```

## Step 7: Verify Automatic App Deployment

### 7.1 Check Device Side

On each enrolled device:

```
Settings → Apps → All apps

You should see: "Device Security Monitor"
Status: System app (cannot uninstall)
Permissions: Granted by MDM policy
```

### 7.2 Check Admin Console

```
https://admin.google.com
Devices and data → Mobile & endpoint management → Android → [Device Name]

Should show:
✅ Compliant: Yes
✅ Policy applied: "Work Devices - Monitoring"
✅ Apps:
   - Device Security Monitor: Installed, Mandatory
   - Other required apps: Installed
```

### 7.3 Monitor Dashboard

```
Your backend monitoring dashboard should show:
- All 15 devices online
- Data flowing from each device
- No connection errors
```

## Step 8: Employee Communication

### 8.1 Pre-Enrollment Email

```
Subject: Work Device Setup - Important Information

Dear [Employee],

Your work Android device is ready for setup. Before proceeding,
please read and sign the Device Monitoring Agreement.

Key points:
✓ This device is company property
✓ It will be monitored for security purposes
✓ Monitoring complies with [State/Country] law
✓ Your personal privacy is protected
✓ You have rights to access your data

Signed agreement required: YES

Setup instructions: [Link to setup guide]
Agreement form: [Link to PDF]
Support contact: [Email/Phone]

Please complete setup by [Date].

Thank you,
IT Security Team
```

### 8.2 Post-Enrollment Email

```
Subject: Device Setup Complete

Dear [Employee],

Your work device is now set up and monitored.

What to expect:
- Device Security Monitor app runs in background
- Reports device health every 30 minutes
- Alerts if security issues detected
- You can request your monitoring data anytime

Questions:
- FAQ: [Link]
- Support: [Email]
- Privacy: [Link to policy]

Thank you for keeping our data secure.
```

## Step 9: Compliance & Documentation

### 9.1 Document Everything

Create records for:
- [ ] Enrollment token creation date & expiration
- [ ] Employee consent forms (signed originals)
- [ ] Device enrollment dates & serial numbers
- [ ] Policy application confirmation
- [ ] Employee training completion
- [ ] Policy acknowledgments

### 9.2 Ongoing Compliance

**Monthly:**
- Review enrolled devices list
- Check for policy violations
- Verify app installation status
- Monitor device compliance

**Quarterly:**
- Legal compliance audit
- Employee feedback review
- Policy updates if needed
- Security testing

**Annually:**
- Full compliance review
- Legal advisor sign-off
- Penetration testing
- Documentation update

## Troubleshooting

### Device Won't Enroll

```
Problem: "Enrollment token not recognized"
Solution:
1. Verify token not expired (check admin console)
2. Create new token if needed
3. Ensure device is on WiFi
4. Try again from initial setup screen
```

```
Problem: "Google account not recognized"
Solution:
1. Verify company email is correct
2. Employee may need Google Workspace account created first
3. Wait 24 hours for account to propagate
4. Try enrollment again
```

### App Won't Install

```
Problem: "Device Security Monitor not installing"
Solution:
1. Check app published in Managed Google Play (wait 4 hours)
2. Verify policy applied to device
3. Device may need reboot
4. Check app isn't blocked in policy
5. Clear Google Play cache on device
```

### Device Shows Non-Compliant

```
Check what's non-compliant in Admin Console
Common issues:
- Lock screen not set
- Weak password
- USB debugging enabled
- Developer options visible

Fix: Go to Settings and enable required security features
```

## Unenrollment (If Needed)

### To Remove a Device from MDM:

```
Admin Console → Devices → Android → [Device]
Click "Actions" → "Unenroll device"

Options:
- Keep user accounts (data preserved)
- Remove user accounts (full factory reset)

Choice: Select based on device return/retention policy
```

## Security Best Practices

✅ **DO:**
- Regularly review device compliance status
- Monitor for policy violations
- Update policies as threats evolve
- Keep Google Workspace updated
- Document all device enrollment/unenrollment
- Review employee data access requests
- Conduct annual security audits

❌ **DON'T:**
- Share admin credentials
- Enroll personal devices without consent
- Disable required security features
- Allow uncontrolled app installations
- Ignore policy violations
- Delete audit logs prematurely
- Monitor beyond stated scope

## Support & Resources

**Google Workspace Support:**
- https://support.google.com/a/topic/7558155 (Android Management)
- https://support.google.com/a/answer/7576144 (Managed Google Play)

**Google Admin Console Help:**
- https://support.google.com/a/topic/2711070

**Your IT Support:**
- [Your support email]
- [Your support phone]

---

**Questions?** Contact your Google Workspace admin or IT security team.
