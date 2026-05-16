-- Device Monitoring Database Schema
-- PostgreSQL

-- Devices Table
CREATE TABLE devices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id VARCHAR(255) NOT NULL UNIQUE,
    device_name VARCHAR(255),
    device_model VARCHAR(255),
    os_version VARCHAR(50),
    api_version INT,
    employee_id VARCHAR(255) NOT NULL,
    employee_email VARCHAR(255),
    device_type VARCHAR(50),
    status VARCHAR(50) DEFAULT 'active',
    last_seen TIMESTAMP,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_encrypted BOOLEAN DEFAULT true,
    public_key TEXT,
    
    CONSTRAINT valid_status CHECK (status IN ('active', 'inactive', 'suspended', 'lost'))
);

CREATE INDEX idx_devices_device_id ON devices(device_id);
CREATE INDEX idx_devices_employee_id ON devices(employee_id);
CREATE INDEX idx_devices_status ON devices(status);

-- Device Reports (monitoring data)
CREATE TABLE device_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    report_timestamp TIMESTAMP NOT NULL,
    battery_level INT,
    storage_free_mb INT,
    memory_available_mb INT,
    screen_on BOOLEAN,
    wifi_connected BOOLEAN,
    mobile_connected BOOLEAN,
    airplane_mode BOOLEAN,
    usb_connected BOOLEAN,
    apps_count INT,
    data_encrypted BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT valid_battery CHECK (battery_level >= 0 AND battery_level <= 100)
);

CREATE INDEX idx_reports_device_id ON device_reports(device_id);
CREATE INDEX idx_reports_timestamp ON device_reports(report_timestamp);
CREATE INDEX idx_reports_created_at ON device_reports(created_at);

-- Network Connections
CREATE TABLE network_connections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    connection_type VARCHAR(20),
    ip_address INET,
    hostname VARCHAR(255),
    port INT,
    protocol VARCHAR(20),
    is_suspicious BOOLEAN DEFAULT false,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT valid_port CHECK (port >= 0 AND port <= 65535)
);

CREATE INDEX idx_network_device_id ON network_connections(device_id);
CREATE INDEX idx_network_timestamp ON network_connections(timestamp);
CREATE INDEX idx_network_suspicious ON network_connections(is_suspicious);

-- USB Connections
CREATE TABLE usb_connections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    usb_device_name VARCHAR(255),
    usb_device_id VARCHAR(255),
    manufacturer VARCHAR(255),
    product_name VARCHAR(255),
    connected_at TIMESTAMP,
    disconnected_at TIMESTAMP,
    duration_minutes INT,
    data_transferred_mb INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_usb_device_id ON usb_connections(device_id);
CREATE INDEX idx_usb_timestamp ON usb_connections(created_at);

-- Installed Applications
CREATE TABLE applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    package_name VARCHAR(255) NOT NULL,
    app_name VARCHAR(255),
    version_name VARCHAR(50),
    version_code INT,
    is_system_app BOOLEAN DEFAULT false,
    installation_time TIMESTAMP,
    last_update_time TIMESTAMP,
    is_suspicious BOOLEAN DEFAULT false,
    first_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_apps_device_id ON applications(device_id);
CREATE INDEX idx_apps_package_name ON applications(package_name);
CREATE INDEX idx_apps_suspicious ON applications(is_suspicious);

-- File Access Logs (work folders only)
CREATE TABLE file_access_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    file_path VARCHAR(1024),
    file_name VARCHAR(255),
    access_type VARCHAR(20),
    access_time TIMESTAMP,
    app_package VARCHAR(255),
    is_external_transfer BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT valid_access_type CHECK (access_type IN ('read', 'write', 'delete', 'copy'))
);

CREATE INDEX idx_file_access_device_id ON file_access_logs(device_id);
CREATE INDEX idx_file_access_timestamp ON file_access_logs(access_time);
CREATE INDEX idx_file_access_external ON file_access_logs(is_external_transfer);

-- Security Alerts
CREATE TABLE security_alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    alert_type VARCHAR(100) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    remediation_steps TEXT,
    is_acknowledged BOOLEAN DEFAULT false,
    acknowledged_at TIMESTAMP,
    acknowledged_by VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT valid_severity CHECK (severity IN ('low', 'medium', 'high', 'critical')),
    CONSTRAINT valid_alert_type CHECK (alert_type IN (
        'unauthorized_app_install',
        'suspicious_network',
        'multiple_unlock_failures',
        'usb_data_transfer',
        'encrypted_data_access',
        'malware_detected',
        'root_detected',
        'device_admin_enabled',
        'backup_disabled',
        'unusual_activity'
    ))
);

CREATE INDEX idx_alerts_device_id ON security_alerts(device_id);
CREATE INDEX idx_alerts_severity ON security_alerts(severity);
CREATE INDEX idx_alerts_type ON security_alerts(alert_type);
CREATE INDEX idx_alerts_created_at ON security_alerts(created_at);
CREATE INDEX idx_alerts_acknowledged ON security_alerts(is_acknowledged);

-- Audit Log (who accessed what data and when)
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    admin_id VARCHAR(255) NOT NULL,
    admin_email VARCHAR(255),
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(100),
    resource_id VARCHAR(255),
    details JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_admin_id ON audit_logs(admin_id);
CREATE INDEX idx_audit_action ON audit_logs(action);
CREATE INDEX idx_audit_created_at ON audit_logs(created_at);

-- Admin Users
CREATE TABLE admin_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'viewer',
    is_active BOOLEAN DEFAULT true,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT valid_role CHECK (role IN ('admin', 'security_officer', 'viewer', 'auditor'))
);

CREATE INDEX idx_admin_email ON admin_users(email);
CREATE INDEX idx_admin_role ON admin_users(role);

-- Data Access Requests (for employee privacy)
CREATE TABLE data_access_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id VARCHAR(255) NOT NULL,
    employee_email VARCHAR(255),
    device_id UUID REFERENCES devices(id) ON DELETE SET NULL,
    request_type VARCHAR(50),
    date_range_start DATE,
    date_range_end DATE,
    status VARCHAR(20) DEFAULT 'pending',
    response_data JSONB,
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responded_at TIMESTAMP,
    
    CONSTRAINT valid_status CHECK (status IN ('pending', 'approved', 'denied', 'completed'))
);

CREATE INDEX idx_data_requests_employee_id ON data_access_requests(employee_id);
CREATE INDEX idx_data_requests_status ON data_access_requests(status);
CREATE INDEX idx_data_requests_requested_at ON data_access_requests(requested_at);

-- Grant Permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO monitor_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO monitor_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO monitor_user;