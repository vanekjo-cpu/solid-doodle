# Google Workspace Enrollment Token Management

## What is an Enrollment Token?

An enrollment token is a security code that employees use to enroll their Android devices in your Google Workspace MDM.

**Token Format:**
```
1234567890:ABCDEFG1234567890ABCDEFG1234567890ABCDEFG
```

## Creating Enrollment Tokens

### Method 1: Create Per-Employee Tokens (Recommended)

Each employee gets their own token, allowing you to:
- Track who enrolled which device
- Revoke specific employee tokens if needed
- Set token expiration per employee
- Better audit trail

**Steps:**

```
1. Go to admin.google.com
2. Left menu → Devices and data → Mobile & endpoint management → Android
3. Click "Create enrollment token"
4. For each employee:
   - Token name: "[Employee Name] - Device Monitor"
   - Expiration: 30 days (employee must enroll by deadline)
   - Device Management Level: "Full management"
   - Click Create
   - Share token with employee via secure method
```

### Method 2: Create Organization-Wide Token

One token shared with all 15 employees.

**Pros:**
- Simpler distribution
- Single management point

**Cons:**
- Less audit trail
- Can't revoke per employee
- Token applies to entire OU

**Steps:**

```
1. Go to admin.google.com
2. Left menu → Devices and data → Mobile & endpoint management → Android
3. Click "Create enrollment token"
4. Name: "Organization-Wide Device Enrollment"
5. Expiration: 60 days
6. Device Management Level: "Full management"
7. Click Create
8. Share with all 15 employees
```

## Token Expiration

### Why Tokens Expire

- **Security:** Prevents old tokens being used for unauthorized enrollment
- **Control:** Forces periodic re-enrollment process
- **Compliance:** Ensures current policy versions are used

### Recommended Expiration Periods

```
Per-Employee Tokens: 30 days
  → Employee must enroll device within 30 days
  → After expiration, create new token for employee

Organization-Wide Token: 60 days
  → For rolling enrollment (devices added over time)
  → Create new token before expiration
  → Old token remains active until explicitly revoked
```

## Distributing Tokens Securely

### Option 1: Email (Quick)

```
Subject: Your Work Device Enrollment Token [CONFIDENTIAL]

Dear [Employee],

Your device enrollment token:

1234567890:ABCDEFG1234567890ABCDEFG1234567890ABCDEFG

Expires: [Date]
To enroll your device:
1. Power on your Android device
2. Go through initial setup
3. When prompted for enrollment token, enter the code above
4. Complete setup

Do NOT share this token with others.
Do NOT store in unsecured locations.

Questions? Contact IT Support
```

❌ **Risk:** Email can be forwarded or intercepted

### Option 2: Secure Portal (Better)

```
Create employee portal:
  https://devices.yourcompany.com/enrollment

Employee:
1. Logs in with company email
2. Sees their personal enrollment token
3. Token shown only when needed
4. Token expires after viewing (one-time use)
```

✅ **Benefit:** Secure, trackable, one-time use

### Option 3: In-Person (Most Secure)

```
1. Meet employee in person
2. Print token on paper (unique per employee)
3. Employee enters token during device setup
4. Destroy paper afterward
5. No digital record of token distribution
```

✅ **Benefit:** Most secure, best compliance

## Managing Active Tokens

### View Active Tokens

```
admin.google.com
Devices and data → Mobile & endpoint management → Android

You'll see:
- Token value
- Creation date
- Expiration date
- Associated organizational unit
- Device count enrolled with token
```

### Revoke a Token (Before Expiration)

```
If you need to revoke a token early:

admin.google.com
Devices and data → Mobile & endpoint management → Android

Find token
Click "Revoke"
Confirm revocation

Result:
- Token no longer works for new enrollments
- Already-enrolled devices remain enrolled
- Employees cannot enroll new devices with revoked token
```

### Extend Token Expiration

```
If you need to extend an expiring token:

❌ Google Workspace doesn't allow extending tokens

✅ Solution: Create a new token before old one expires
  - Old token remains active until expiration date
  - New token available for ongoing enrollment
  - Announce new token to employees
```

## Token Renewal Cycle

### Recommended Process

```
Month 1: Create initial token (expires day 30)
  ↓
Month 1: Distribute to all 15 employees
  ↓
Month 2 (Day 25): All devices should be enrolled
  ↓
Month 2 (Day 25): Create new token (expires day 55 of Month 2)
  ↓
Month 2 (Day 28): Announce new token for replacement devices
  ↓
Month 2 (Day 30): Old token expires (no new enrollments)
  ↓
Month 3: Continue with new token
  ↓
Month 3 (Week 4): Create next token (for ongoing needs)
```

## Monitoring Enrollment Progress

### Check Enrollment Status

```
admin.google.com
Devices and data → Mobile & endpoint management → Android

You'll see:
- Total devices enrolled
- Devices by policy
- Devices by compliance status
- Last sync status
- Policy violations
```

### Verify All 15 Devices

Create checklist:

```
Employee Name          | Device Model    | Enrolled | Compliant | Notes
----------------------------
1. John Doe           | Samsung S23     | ✓        | ✓         | 
2. Jane Smith         | Google Pixel 7  | ✓        | ✓         |
3. Bob Johnson        | OnePlus 11      | Pending  |           | Token expires day 10
...
15. [Employee 15]     | [Model]         | ✓        | ✓         |
```

## Token Security Best Practices

### What You Should Do

✅ Create unique token per employee (if possible)
✅ Set reasonable expiration (30-60 days)
✅ Share tokens securely (email + portal or in-person)
✅ Log token distribution
✅ Monitor enrollment status
✅ Revoke tokens if compromise suspected
✅ Document token lifecycle
✅ Create new tokens before old ones expire
✅ Communicate deadlines to employees
✅ Follow up on non-enrolled devices

### What You Should NOT Do

❌ Share token via unsecured chat/SMS
❌ Post token publicly
❌ Use same token across multiple organizations
❌ Allow employees to share tokens
❌ Store tokens in plain text files
❌ Forget to revoke compromised tokens
❌ Let tokens expire without replacement
❌ Ignore unenrolled devices
❌ Trust employees with token management

## Troubleshooting Token Issues

### Problem: "Invalid Enrollment Token"

```
Possible causes:
1. Token expired
   → Create new token
   → Share new token with employee

2. Token typed incorrectly
   → Have employee re-enter carefully
   → Use copy/paste if available

3. Device already enrolled
   → Factory reset device
   → Enroll again with valid token

4. Organizational unit mismatch
   → Verify employee is in correct OU
   → Enrollment token matches employee's OU
```

### Problem: "Token Expired"

```
Solution:
1. Go to admin.google.com
2. Create new enrollment token
3. Share new token immediately
4. Employee re-enrolls with new token
```

### Problem: "Can't Find My Token"

```
If employee loses token:
1. Go to admin.google.com
2. Find employee in Directory
3. Generate new token
4. Share securely
5. Employee enrolls with new token
```

## Compliance & Audit Trail

### Maintain Records

```
For each enrollment token, document:

📋 Token Log:
- Token value
- Creation date & time
- Expiration date & time
- Assigned to: [Employee name]
- Distribution method: [Email/Portal/In-person]
- Distribution date
- Enrollment date
- Device information
- Status: Active/Revoked/Expired
```

### Audit Log Template

```
Token Management Audit Trail

Date          | Action              | Token (first 20 chars) | Status    | Notes
---
2026-05-16    | Token created       | 1234567890:ABCDEFG... | Active    | Employee: John Doe
2026-05-16    | Token distributed   | 1234567890:ABCDEFG... | Active    | Via email
2026-05-18    | Device enrolled     | 1234567890:ABCDEFG... | Active    | Phone enrolled
2026-05-20    | Token revoked       | 1234567890:ABCDEFG... | Revoked   | Compromise suspected
2026-05-20    | New token created   | 0987654321:GFEDCBA... | Active    | Replacement
```

---

**Keep these records for legal compliance (minimum 1-2 years)**
