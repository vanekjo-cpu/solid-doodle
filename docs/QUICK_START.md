# Quick Start Guide - Device Monitor Deployment

## Timeline

```
Week 1-2: Legal & Preparation
Week 3: Google Workspace Setup
Week 4: Token Creation & Distribution
Week 5: Device Enrollment
Week 6: Verification & Troubleshooting
Week 7+: Ongoing Monitoring
```

## Checklist

### Week 1-2: Legal Phase

- [ ] Have lawyer review legal docs (LEGAL.md)
- [ ] Customize employee agreement
- [ ] Get HR approval
- [ ] Print agreements (15 copies)
- [ ] Schedule employee meetings
- [ ] Prepare training materials

### Week 3: Google Workspace Setup

**Prerequisites:**
- [ ] Google Workspace Business Standard+ account
- [ ] Admin access
- [ ] 15 Android devices (Android 10+)

**Steps:**

1. **Enable MDM** (1 hour)
   ```
   admin.google.com → Devices and data → Mobile & endpoint management → Settings
   Check: "Allow users to enroll Android devices"
   Check: "Android Management API"
   Save
   ```

2. **Set Up Managed Google Play** (24 hours wait)
   ```
   admin.google.com → Devices and data → Managed Google Play
   Click "Set up Managed Google Play"
   Accept terms
   Wait 24 hours for activation
   ```

3. **Upload APK** (2 hours)
   ```
   https://play.google.com/apps/publish/
   Create new app
   Upload signed APK
   Fill in app details
   Publish to production
   Wait 2-4 hours for availability
   ```

4. **Create Android Policy** (1 hour)
   ```
   admin.google.com → Devices and data → Android
   Click "Create policy"
   Name: "Work Devices - Monitoring"
   Add app: Device Security Monitor (Mandatory, no uninstall)
   Configure security settings
   Save
   ```

5. **Create Organization Unit** (30 min)
   ```
   admin.google.com → Directory → Organizational units
   Create: "Work Devices"
   Move 15 employees to this OU
   ```

6. **Assign Policy to OU** (15 min)
   ```
   admin.google.com → Devices and data → Android → Your Policy
   Go to Deployment
   Assign to: "Work Devices" OU
   Apply
   ```

### Week 4: Enrollment Tokens

- [ ] Create enrollment token (or 15 individual tokens)
   ```
   admin.google.com → Devices and data → Android
   Click "Create enrollment token"
   Name: "Device Monitor Enrollment"
   Expiration: 30 days
   Create
   ```

- [ ] Distribute tokens securely
  - Email to employees with instructions
  - Or print and hand out in person
  - Document distribution date

- [ ] Communicate deadline
  - Send enrollment instructions
  - Provide support contact
  - Set deadline (e.g., 2 weeks)

### Week 5: Device Enrollment

**Employee Steps (per device):**

1. Power on device
2. Select "Set up for work" (if available)
3. Enter company email
4. Log in with company credentials
5. Enter enrollment token when prompted
6. Accept MDM enrollment
7. Wait for policy (5-10 min)
8. App installs automatically
9. Done!

**Admin Monitoring:**

- Track enrollment progress in admin console
- Verify all 15 devices enroll by deadline
- Troubleshoot any issues

### Week 6: Verification

**Check each device:**

```
✓ Appears in admin console
✓ Status: Compliant
✓ Policy: "Work Devices - Monitoring" applied
✓ App: "Device Security Monitor" installed
✓ Cannot be uninstalled (MDM protected)
✓ Device shows "Online" in monitoring dashboard
✓ Reporting data to backend
```

**Admin Console Check:**

```bash
admin.google.com
Devices and data → Mobile & endpoint management → Android

You should see:
- 15 devices listed
- All showing "Compliant: Yes"
- All with latest policy
- All last synced within 1 hour
```

**Monitoring Dashboard Check:**

```bash
https://your-monitoring-dashboard.com

You should see:
- 15 devices online
- Data flowing from each device
- No connection errors
- Real-time status of all devices
```

### Week 7+: Ongoing Operations

**Weekly:**
- Review device compliance status
- Check for alerts
- Monitor app installation

**Monthly:**
- Review monitoring data
- Check policy violations
- Employee check-ins
- Document findings

**Quarterly:**
- Security audit
- Legal compliance review
- Policy updates if needed
- Employee feedback gathering

**Annually:**
- Full compliance audit
- Legal advisor sign-off
- Penetration testing
- Policy refresh

## Support Contacts

**Google Workspace Support:**
- https://support.google.com/a/topic/7558155

**Your IT/Security Team:**
- Name: ____________________
- Email: ____________________
- Phone: ____________________

**Employee Support:**
- FAQ: [Link]
- Support Email: ____________________
- Support Phone: ____________________

## Important Files

- `README.md` - Project overview
- `docs/LEGAL.md` - Legal requirements (READ FIRST!)
- `docs/EMPLOYEE_AGREEMENT.md` - Consent form
- `docs/GOOGLE_WORKSPACE_SETUP.md` - This setup guide
- `docs/ENROLLMENT_TOKEN_GUIDE.md` - Token management
- `docs/DEPLOYMENT.md` - Technical deployment
- `docs/API.md` - API documentation

## Success Metrics

**Enrollment:**
- [ ] 15/15 devices enrolled (100%)
- [ ] All devices compliant
- [ ] All devices reporting data
- [ ] No enrollment failures

**Security:**
- [ ] All devices have lock screen
- [ ] All devices encrypted
- [ ] No USB transfers
- [ ] No unknown apps installed

**Compliance:**
- [ ] All consent forms signed
- [ ] Legal review completed
- [ ] Policies documented
- [ ] Training completed
- [ ] Audit trail maintained

---

**Stuck? Check troubleshooting sections in the detailed guides above.**
