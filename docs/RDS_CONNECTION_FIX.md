# Fixing RDS Connection Timeout from Streamlit Cloud

## Your Error

```
connection to server at "epdauto-db.cl8ecgcsgosb.us-east-2.rds.amazonaws.com" (18.189.55.250), 
port 5432 failed: Connection timed out
```

This is a **network/security configuration issue**, not a code problem.

## Quick Fix Checklist

Follow these steps in order:

- [ ] Step 1: Enable Public Accessibility on RDS
- [ ] Step 2: Update Security Group Inbound Rules
- [ ] Step 3: Verify Network ACLs
- [ ] Step 4: Test Connection
- [ ] Step 5: Verify Streamlit Cloud Secrets

---

## Step 1: Enable Public Accessibility

### In AWS Console:

1. Go to **RDS** → **Databases**
2. Click on your database: `epdauto-db`
3. Click **"Modify"**
4. Scroll to **"Connectivity"** section
5. Under **"Public access"**, select **"Publicly accessible"**
6. Click **"Continue"**
7. Under **"Scheduling of modifications"**, choose:
   - **"Apply immediately"** (recommended)
8. Click **"Modify DB instance"**

**Wait 5-10 minutes** for the change to apply.

---

## Step 2: Update Security Group Inbound Rules

### Find Your Security Group:

1. In RDS database details, note the **Security Group** name (e.g., `sg-xxxxx`)
2. Go to **EC2** → **Security Groups**
3. Find and select your security group

### Add Inbound Rule:

1. Click **"Edit inbound rules"**
2. Click **"Add rule"**
3. Configure:
   - **Type**: `PostgreSQL`
   - **Protocol**: `TCP`
   - **Port range**: `5432`
   - **Source**: 
     - **Option A** (Quick test): `0.0.0.0/0` (allows all IPs - **less secure**)
     - **Option B** (Recommended): Specific Streamlit Cloud IPs (see below)
4. Click **"Save rules"**

### Streamlit Cloud IP Ranges (Option B):

Streamlit Cloud uses dynamic IPs. For testing, use `0.0.0.0/0`, then restrict later.

**For production**, you can:
- Use AWS RDS Proxy (recommended)
- Set up VPC peering
- Use a bastion host

---

## Step 3: Verify Network ACLs

### Check VPC Network ACLs:

1. Go to **VPC** → **Network ACLs**
2. Find the ACL associated with your RDS subnet
3. Check **Inbound Rules**:
   - Should allow TCP port 5432 from `0.0.0.0/0` (or specific IPs)
4. Check **Outbound Rules**:
   - Should allow responses back

**Default ACLs usually allow all traffic**, but verify if you have custom ACLs.

---

## Step 4: Test Connection

### Test from Your Local Machine:

```bash
# Test if RDS is reachable
psql -h epdauto-db.cl8ecgcsgosb.us-east-2.rds.amazonaws.com \
     -U your_username \
     -d your_database_name \
     -p 5432
```

**If this works locally**, the issue is Streamlit Cloud network access.

**If this fails locally**, the RDS configuration needs more work.

### Test with Python:

```python
import psycopg2
import os

try:
    conn = psycopg2.connect(
        host="epdauto-db.cl8ecgcsgosb.us-east-2.rds.amazonaws.com",
        port=5432,
        database="your_database",
        user="your_username",
        password="your_password",
        connect_timeout=10
    )
    print("✅ Connection successful!")
    conn.close()
except Exception as e:
    print(f"❌ Connection failed: {e}")
```

---

## Step 5: Verify Streamlit Cloud Secrets

### In Streamlit Cloud:

1. Go to your app on [share.streamlit.io](https://share.streamlit.io)
2. Click **"Settings"** → **"Secrets"**
3. Verify your secrets are exactly:

```toml
DB_NAME = "your_database_name"
DB_USER = "your_database_user"
DB_PASSWORD = "your_database_password"
DB_HOST = "epdauto-db.cl8ecgcsgosb.us-east-2.rds.amazonaws.com"
DB_PORT = "5432"
```

**Important**:
- No quotes needed around values in TOML
- No trailing spaces
- Host should be the full RDS endpoint (no `https://` or `http://`)

---

## Step 6: Verify RDS Endpoint

### Check Your RDS Endpoint:

1. Go to **RDS** → **Databases** → Your database
2. Under **"Connectivity & security"**, verify:
   - **Endpoint**: `epdauto-db.cl8ecgcsgosb.us-east-2.rds.amazonaws.com`
   - **Port**: `5432`
   - **Publicly accessible**: Should show **"Yes"**

---

## Alternative Solutions

### Option A: Use RDS Proxy (Recommended for Production)

RDS Proxy handles connection pooling and can be more reliable:

1. **Create RDS Proxy**:
   - Go to **RDS** → **Proxies** → **Create proxy**
   - Select your RDS instance
   - Configure security groups (allow Streamlit Cloud IPs)
   - Note the proxy endpoint

2. **Update Streamlit Secrets**:
   ```toml
   DB_HOST = "your-proxy-endpoint.proxy-xxxxx.us-east-2.rds.amazonaws.com"
   ```

### Option B: Use Bastion Host

1. Set up an EC2 instance in the same VPC as RDS
2. Configure security groups
3. Use SSH tunnel (more complex, but more secure)

### Option C: VPC Peering

1. Set up VPC peering between Streamlit Cloud and AWS
2. Keep RDS private
3. Configure routing (advanced setup)

---

## Common Mistakes

### ❌ Wrong Security Group

Make sure you're editing the security group **attached to the RDS instance**, not a different one.

### ❌ Wrong Subnet

RDS must be in a **public subnet** (with Internet Gateway) to be publicly accessible.

### ❌ Firewall on Your Machine

If testing locally, ensure your firewall allows outbound connections on port 5432.

### ❌ Wrong Endpoint

Use the **RDS endpoint**, not the instance name or IP address.

### ❌ Credentials in Code

Never hardcode credentials. Always use Streamlit Cloud secrets or `.env` file.

---

## Verification Steps

After making changes:

1. **Wait 5-10 minutes** for changes to propagate
2. **Test connection** from local machine first
3. **Check Streamlit Cloud logs** for connection attempts
4. **Verify security group** shows the new inbound rule
5. **Test from Streamlit app** - try fetching data

---

## Still Not Working?

### Debug Steps:

1. **Check RDS Status**:
   - Ensure RDS instance is **"Available"** (not "Modifying" or "Backing-up")

2. **Check Security Group**:
   - Verify rule is saved and active
   - Check rule number (lower numbers = higher priority)

3. **Check VPC Route Tables**:
   - Ensure public subnet has route to Internet Gateway

4. **Check RDS Subnet Group**:
   - Verify subnets have Internet Gateway access

5. **Test with Telnet** (if available):
   ```bash
   telnet epdauto-db.cl8ecgcsgosb.us-east-2.rds.amazonaws.com 5432
   ```
   Should connect (you'll see connection message)

6. **Check AWS CloudWatch Logs**:
   - Look for connection attempts in RDS logs

### Contact AWS Support If:

- All steps completed but still timing out
- Security group rules not taking effect
- RDS modification stuck

---

## Security Best Practices

Once connection works:

1. **Restrict Security Group**:
   - Instead of `0.0.0.0/0`, use specific IP ranges
   - Or use RDS Proxy for better security

2. **Enable SSL**:
   ```python
   engine = create_engine(
       connection_string,
       connect_args={"sslmode": "require"}
   )
   ```

3. **Use Strong Passwords**:
   - Rotate passwords regularly
   - Use AWS Secrets Manager

4. **Monitor Access**:
   - Enable CloudTrail
   - Monitor RDS connection logs

---

## Quick Reference

### Your RDS Details:
- **Endpoint**: `epdauto-db.cl8ecgcsgosb.us-east-2.rds.amazonaws.com`
- **Region**: `us-east-2` (Ohio)
- **Port**: `5432`

### Required Settings:
- ✅ Publicly accessible: **Yes**
- ✅ Security group: Allow PostgreSQL (5432) from `0.0.0.0/0` (or specific IPs)
- ✅ Network ACLs: Allow traffic
- ✅ Streamlit secrets: Correct endpoint and credentials

---

## Next Steps

After fixing the connection:

1. Test your Streamlit app
2. Verify data fetching works
3. Consider implementing RDS Proxy for production
4. Review security settings

---

**Need More Help?** Check the [Troubleshooting Guide](09-troubleshooting.md) or [Deployment Guide](08-deployment.md).
