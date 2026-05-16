# Deployment Guide - Android Device Monitoring System

## Pre-Deployment Checklist

Before deploying to ANY device:

- [ ] Legal review completed (lawyer approved)
- [ ] Employee monitoring policy created and distributed
- [ ] Written consent obtained from all 15 employees (signed forms)
- [ ] HR approved monitoring plan
- [ ] Backend server configured and tested
- [ ] Database created with encryption
- [ ] Android APK built and signed with your company key
- [ ] Test deployment on 1-2 devices first

## Deployment Methods

### Option 1: Mobile Device Management (MDM) - RECOMMENDED

For organizations with 15+ devices, MDM is the best approach.

#### Using Google Workspace (formerly G Suite)

1. **Set up Android Device Management:**
   ```
   1. Go to admin.google.com
   2. Device management → Android devices
   3. Create device enrollment policy
   4. Enable app management
   ```

2. **Upload APK to Play Store for Work:**
   ```
   1. Create managed Google Play account
   2. Upload signed APK
   3. Set to auto-install on enrolled devices
   4. Configure deployment rules
   ```

3. **Enroll Devices:**
   ```
   1. Give employees enrollment code
   2. Devices enroll when powered on
   3. App auto-installs via managed Play Store
   4. Employees cannot uninstall
   ```

#### Using Samsung Knox (for Samsung devices)

1. **Access Samsung Knox Manage Portal**
   - Register organization
   - Create deployment policy

2. **Configure APK Distribution**
   - Upload signed APK
   - Set deployment to "mandatory"
   - Schedule deployment time

3. **Deploy to Devices**
   - Devices must be Samsung (Galaxy S series)
   - Automatic deployment via Knox platform
   - Employees cannot uninstall

#### Using Microsoft Intune (cross-platform)

1. **Set up Intune:**
   ```
   1. Azure Portal → Intune
   2. Devices → Android enrollment
   3. Create enrollment policy
   ```

2. **Add App:**
   ```
   1. Intune → Apps → Add
   2. Upload signed APK
   3. Set as required app
   4. Deploy to device group
   ```

3. **Monitor Deployment:**
   - Check installation status
   - View device compliance
   - Force install on non-compliant devices

### Option 2: Manual Deployment via ADB (Smaller Scale)

For 15 devices, this is feasible but time-consuming.

#### Prerequisites

```bash
# Install Android Debug Bridge
# Linux/Mac:
brew install android-platform-tools

# Windows:
# Download from Android SDK

# Verify installation:
adb version
```

#### Enable Developer Mode on Each Device

1. Settings → About phone
2. Tap "Build number" 7 times
3. Go to Settings → Developer Options
4. Enable "USB Debugging"
5. Accept USB debugging prompt

#### Deploy APK

```bash
# Connect device via USB
adb devices  # Should show device ID

# Install APK
adb install -r app-release.apk

# Verify installation
adb shell pm list packages | grep com.yourcompany.monitor

# Grant permissions
adb shell pm grant com.yourcompany.monitor android.permission.READ_EXTERNAL_STORAGE
adb shell pm grant com.yourcompany.monitor android.permission.ACCESS_NETWORK_STATE
adb shell pm grant com.yourcompany.monitor android.permission.GET_TASKS

# Start the service
adb shell am startservice com.yourcompany.monitor/.DeviceMonitorService
```

#### Prevent Uninstallation

```bash
# Make app a system app (requires rooting - NOT RECOMMENDED)
# Alternative: Use MDM instead
```

### Option 3: Custom APK Distribution Server

For internal distribution via your own server:

1. **Host APK on Internal Server**
   ```
   https://monitor.yourcompany.com/device-monitor.apk
   ```

2. **Send Download Link to Employees**
   - Email with monitoring agreement
   - Include installation instructions
   - Request confirmation after installation

3. **Verify Installation**
   - Check device reporting to backend
   - Cross-reference with employee list

⚠️ **Risk:** Employees can uninstall without MDM

## Backend Server Setup

### 1. Database Setup

#### PostgreSQL (Recommended)

```bash
# Create database
sudo -u postgres psql

CREATE DATABASE device_monitor;
CREATE USER monitor_user WITH PASSWORD 'strong_password_here';
ALTER ROLE monitor_user SET client_encoding TO 'utf8';
ALTER ROLE monitor_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE monitor_user SET default_transaction_deferrable TO on;
ALTER ROLE monitor_user SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE device_monitor TO monitor_user;
\q

# Run migrations
cd backend-api
npm run migrate
```

### 2. API Server Setup

```bash
# Clone/setup backend
cd backend-api

# Install dependencies
npm install

# Configure environment
cp .env.example .env

# Edit .env with your settings:
echo "DB_HOST=localhost

DB_PORT=5432
DB_NAME=device_monitor
DB_USER=monitor_user
DB_PASSWORD=your_password
API_PORT=3000
API_SECRET=your_jwt_secret
BACKEND_URL=https://monitor.yourcompany.com" > .env

# Start server
npm start

# Verify it's running
curl http://localhost:3000/health
```

### 3. Reverse Proxy (Nginx)

```nginx
server {
    listen 443 ssl http2;
    server_name monitor.yourcompany.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    ssl_protocols TLSv1.2 TLSv1.3;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Rate limiting
    limit_req_zone $binary_remote_addr zone=api_limit:10m rate=10r/s;
    limit_req zone=api_limit burst=20 nodelay;
}
```

## Android APK Configuration

### Update API Endpoint

**File: `android-agent/app/src/main/res/values/strings.xml`**

```xml
<string name="api_base_url">https://monitor.yourcompany.com/api</string>
<string name="reporting_interval_minutes">30</string>
<string name="enable_wifi_monitoring">true</string>
<string name="enable_usb_monitoring">true</string>
<string name="enable_app_monitoring">true</string>
```

### Build Signed APK

```bash
cd android-agent

# Create keystore (one time)
keytool -genkey -v -keystore release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias monitoring_app

# Build signed release APK
./gradlew bundleRelease

# Sign the APK
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \
  -keystore release.keystore app-release-unsigned.apk monitoring_app

# Optimize APK
zipalign -v 4 app-release-unsigned.apk app-release.apk

# Verify signature
jarsigner -verify -verbose -certs app-release.apk
```

## Phased Deployment Plan

### Phase 1: Test (Week 1)

1. Deploy to 2 test devices (your team)
2. Verify connectivity to backend
3. Check data collection accuracy
4. Test alert system
5. Review logs for errors

### Phase 2: Pilot (Week 2-3)

1. Deploy to 3 volunteer employees
2. Gather feedback
3. Monitor for issues
4. Refine configuration
5. Document lessons learned

### Phase 3: Full Rollout (Week 4+)

1. Deploy to remaining 10 devices
2. Provide employee training
3. Answer questions/concerns
4. Monitor all deployments
5. Weekly check-ins

### Phase 4: Stabilization (Weeks 5-8)

1. Monitor for issues
2. Fine-tune settings
3. Regular security reviews
4. Employee feedback collection
5. Documentation updates

## Post-Deployment

### Verification Checklist

- [ ] All 15 devices show "Online" in dashboard
- [ ] Devices submitting reports every 30 minutes
- [ ] No connection errors in logs
- [ ] Alert system functional
- [ ] Data encrypted in database
- [ ] Audit logging working
- [ ] Employee can access their data
- [ ] Backup system running

### Employee Communication

1. **Announcement Email**
   - Explain monitoring purpose
   - Link to monitoring policy
   - FAQ document
   - Contact for questions

2. **Training Session**
   - Demonstrate dashboard (what they can see)
   - Explain how to request their data
   - Q&A session
   - Provide support contact

3. **Ongoing Support**
   - Help desk contact: support@yourcompany.com
   - Monthly email update with stats
   - Quarterly review with employees

## Troubleshooting

### Device Not Connecting

```bash
# Check device logs
adb logcat | grep "DeviceMonitorService"

# Verify permissions
adb shell pm list permissions | grep monitoring

# Check network connectivity
adb shell ping -c 4 monitor.yourcompany.com

# Restart service
adb shell am startservice com.yourcompany.monitor/.DeviceMonitorService
```

### API Not Receiving Data

```bash
# Check server logs
tail -f /var/log/nginx/access.log
tail -f /var/log/app.log

# Verify API endpoint
curl -X GET https://monitor.yourcompany.com/api/health

# Check database connection
psql -h localhost -U monitor_user -d device_monitor -c "SELECT 1"
```

### Encryption Issues

```bash
# Verify TLS certificate
openssl s_client -connect monitor.yourcompany.com:443

# Check certificate expiration
openssl x509 -in cert.pem -noout -dates
```

## Maintenance Schedule

**Weekly:**
- Review error logs
- Check device connectivity status
- Monitor database disk usage

**Monthly:**
- Security patches
- Database maintenance
- Employee data access review
- Retention policy enforcement

**Quarterly:**
- Full security audit
- Backup verification
- Policy review
- Employee feedback collection

**Annually:**
- Legal compliance review
- Penetration testing
- System architecture review
- Policy updates

## Undeployment (If Needed)

If you need to remove monitoring:

1. **Notify employees** 30 days in advance
2. **Stop data collection** on backend
3. **Schedule removal date**
4. **Remove APK from devices** (via MDM)
5. **Delete data** (except legal hold items)
6. **Update policy** to reflect changes
7. **Document removal** for compliance

---

**Questions?** Contact your IT security team or legal advisor.