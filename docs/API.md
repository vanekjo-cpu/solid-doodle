# Device Monitor API Documentation

## Base URL

```
https://monitor.yourcompany.com/api
```

## Authentication

All API requests require a JWT token in the Authorization header:

```
Authorization: Bearer <jwt_token>
```

### Device Registration Token

Android agents authenticate with a device-specific token:

```bash
POST /auth/register-device
Content-Type: application/json

{
  "device_id": "abc123def456",
  "device_name": "Worker Phone 1",
  "os_version": "14.0",
  "api_version": 34
}

Response:
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expires_in": 86400,
  "refresh_token": "..."
}
```

## Endpoints

### Device Management

#### Enroll Device

```bash
POST /devices/enroll
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "device_id": "abc123def456",
  "employee_id": "EMP001",
  "employee_email": "john.doe@company.com",
  "device_name": "Samsung Galaxy S23",
  "device_model": "SM-S910U",
  "os_version": "14.0",
  "api_version": 34
}

Response (201):
{
  "id": "uuid",
  "device_id": "abc123def456",
  "status": "active",
  "enrolled_at": "2026-05-16T10:30:00Z",
  "api_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Get Device Status

```bash
GET /devices/{device_id}
Authorization: Bearer <token>

Response (200):
{
  "id": "uuid",
  "device_id": "abc123def456",
  "device_name": "Samsung Galaxy S23",
  "status": "active",
  "last_seen": "2026-05-16T14:25:00Z",
  "enrolled_at": "2026-05-16T10:30:00Z",
  "storage_free_mb": 12345,
  "battery_level": 87,
  "connected_networks": 2,
  "installed_apps": 45,
  "recent_alerts": 2
}
```

#### List All Devices

```bash
GET /devices?status=active&limit=50&offset=0
Authorization: Bearer <admin_token>

Response (200):
{
  "total": 15,
  "devices": [
    { ... device object ... },
    { ... device object ... }
  ]
}
```

#### Update Device Status

```bash
PATCH /devices/{device_id}
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "status": "suspended",
  "reason": "Employee on leave"
}

Response (200):
{
  "id": "uuid",
  "status": "suspended",
  "updated_at": "2026-05-16T14:30:00Z"
}
```

### Monitoring Reports

#### Submit Device Report

Android agent submits monitoring data every 30 minutes:

```bash
POST /reports/submit
Authorization: Bearer <device_token>
Content-Type: application/json

{
  "device_id": "abc123def456",
  "timestamp": "2026-05-16T14:25:00Z",
  "battery_level": 87,
  "storage_free_mb": 12345,
  "memory_available_mb": 4567,
  "screen_on": true,
  "wifi_connected": true,
  "mobile_connected": false,
  "airplane_mode": false,
  "usb_connected": false,
  "apps_count": 45,
  "data_encrypted": true,
  "network_connections": [
    {
      "type": "wifi",
      "ip": "192.168.1.100",
      "hostname": "office-wifi",
      "suspicious": false
    }
  ],
  "installed_apps": [
    {
      "package": "com.google.android.apps.maps",
      "name": "Google Maps",
      "version": "11.0.0",
      "system_app": false,
      "suspicious": false
    }
  ]
}

Response (201):
{
  "id": "uuid",
  "status": "accepted",
  "alerts_triggered": 0
}
```

#### Get Device Reports

```bash
GET /reports/{device_id}?from=2026-05-01&to=2026-05-16&limit=50
Authorization: Bearer <token>

Response (200):
{
  "device_id": "abc123def456",
  "total": 48,
  "reports": [
    { ... report object ... },
    { ... report object ... }
  ]
}
```

### Security Alerts

#### Get Alerts

```bash
GET /alerts?severity=high,critical&status=unacknowledged&limit=20
Authorization: Bearer <token>

Response (200):
{
  "total": 5,
  "alerts": [
    {
      "id": "uuid",
      "device_id": "abc123def456",
      "alert_type": "suspicious_network",
      "severity": "high",
      "title": "Suspicious Network Connection Detected",
      "description": "Device connected to unknown network on port 8080",
      "remediation_steps": "1. Check if this connection is expected...\n2. Review network logs...",
      "created_at": "2026-05-16T13:45:00Z",
      "is_acknowledged": false
    }
  ]
}
```

#### Acknowledge Alert

```bash
POST /alerts/{alert_id}/acknowledge
Authorization: Bearer <token>
Content-Type: application/json

{
  "notes": "Verified connection - employee working from coffee shop"
}

Response (200):
{
  "id": "uuid",
  "is_acknowledged": true,
  "acknowledged_at": "2026-05-16T14:30:00Z"
}
```

### USB Connections

#### Get USB Connection History

```bash
GET /usb/{device_id}?from=2026-05-01&to=2026-05-16
Authorization: Bearer <token>

Response (200):
{
  "device_id": "abc123def456",
  "total": 3,
  "connections": [
    {
      "id": "uuid",
      "device_name": "SanDisk USB Drive",
      "manufacturer": "SanDisk",
      "connected_at": "2026-05-16T09:15:00Z",
      "disconnected_at": "2026-05-16T09:45:00Z",
      "duration_minutes": 30,
      "data_transferred_mb": 245
    }
  ]
}
```

### File Access

#### Get File Access Logs

```bash
GET /files/{device_id}?from=2026-05-01&to=2026-05-16&external_only=true
Authorization: Bearer <token>

Response (200):
{
  "device_id": "abc123def456",
  "total": 12,
  "access_logs": [
    {
      "id": "uuid",
      "file_path": "/data/work/projects/client_data.xlsx",
      "access_type": "copy",
      "access_time": "2026-05-16T11:30:00Z",
      "app_package": "com.android.documentsui",
      "is_external_transfer": true
    }
  ]
}
```

### Data Access Requests (Employee Privacy)

#### Submit Data Access Request

Employees can request their own monitoring data:

```bash
POST /privacy/data-access-request
Content-Type: application/json

{
  "employee_id": "EMP001",
  "employee_email": "john.doe@company.com",
  "device_id": "abc123def456",
  "date_range_start": "2026-05-01",
  "date_range_end": "2026-05-16"
}

Response (201):
{
  "id": "uuid",
  "status": "pending",
  "requested_at": "2026-05-16T14:30:00Z",
  "expected_response_days": 5
}
```

#### Get Data Access Request Status

```bash
GET /privacy/data-access-request/{request_id}

Response (200):
{
  "id": "uuid",
  "status": "completed",
  "requested_at": "2026-05-16T14:30:00Z",
  "responded_at": "2026-05-18T10:00:00Z",
  "data": {
    "reports": [ ... ],
    "alerts": [ ... ],
    "file_access": [ ... ]
  }
}
```

### Health & Status

#### API Health Check

```bash
GET /health

Response (200):
{
  "status": "healthy",
  "timestamp": "2026-05-16T14:30:00Z",
  "database": "connected",
  "version": "1.0.0"
}
```

## Rate Limiting

API rate limits:
- **Device agent:** 10 requests/second
- **Admin API:** 100 requests/minute
- **Public endpoints:** 20 requests/minute

Rate limit headers:
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1621180800
```

## Error Responses

```bash
# 400 Bad Request
{
  "error": "invalid_input",
  "message": "Device ID is required"
}

# 401 Unauthorized
{
  "error": "unauthorized",
  "message": "Invalid or expired token"
}

# 403 Forbidden
{
  "error": "forbidden",
  "message": "You do not have permission to access this resource"
}

# 404 Not Found
{
  "error": "not_found",
  "message": "Device not found"
}

# 429 Too Many Requests
{
  "error": "rate_limited",
  "message": "Too many requests. Retry after 60 seconds"
}

# 500 Internal Server Error
{
  "error": "server_error",
  "message": "An unexpected error occurred"
}
```

## Data Retention & Deletion

- Device reports: 90 days (automatic deletion)
- Alerts: 180 days (automatic deletion)
- Audit logs: 1 year (legal requirement)
- USB connections: 90 days
- File access logs: 90 days

## Compliance Notes

- All data encrypted in transit (TLS 1.2+)
- All data encrypted at rest (AES-256)
- All API access logged in audit trail
- Employees can request their data
- Data deletion honored within 10 business days

## Webhook Events

Optional: Configure webhooks for real-time alerts:

```bash
POST /webhooks/configure
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "url": "https://your-system.com/webhook",
  "events": ["alert_triggered", "device_offline", "suspicious_activity"],
  "secret": "your_webhook_secret"
}
```

Webhook payload:
```json
{
  "event": "alert_triggered",
  "timestamp": "2026-05-16T14:30:00Z",
  "device_id": "abc123def456",
  "alert": { ... alert object ... },
  "signature": "sha256=..."
}
```