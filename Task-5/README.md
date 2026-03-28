# Task 5: Firewall Configuration

## Objective
The objective of this task is to secure the Ubuntu server by configuring a firewall that:

- Allows **SSH access only from a specific IP address**
- Allows **HTTP access**
- Allows traffic on **port 8000**
- Restricts unauthorized access to the server

This task was implemented using **UFW (Uncomplicated Firewall)**.

---

## Expected Outcome
A secure firewall configuration that restricts unauthorized access while allowing required services such as:

- SSH (Port 22)
- HTTP (Port 80)
- Docker application (Port 8000)

---

# Step 1: Install UFW

Update the package list and install UFW:

```bash
sudo apt update
sudo apt install ufw -y
```

### Explanation
- `apt update` → Updates package repository information
- `apt install ufw -y` → Installs UFW automatically without confirmation

---

# Step 2: Check Firewall Status

Check whether UFW is currently active or inactive:

```bash
sudo ufw status
```

### Example Output

```bash
Status: inactive
```

This indicates that the firewall is not yet enabled.

---

# Step 3: Configure Default Firewall Policies

Set secure default firewall rules:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### Explanation
- `deny incoming` → Blocks all incoming traffic by default
- `allow outgoing` → Allows the server to make outgoing connections

This creates a secure baseline firewall policy.

---

# Step 4: Allow SSH Access Only from a Specific IP

Allow SSH access only from the administrator’s public IP address.

```bash
sudo ufw allow from YOUR_PUBLIC_IP to any port 22 proto tcp
```

### Example

```bash
sudo ufw allow from 49.205.100.25 to any port 22 proto tcp
```

### Explanation
This rule allows SSH connections:

- only from the specified public IP
- to port `22`
- using the `TCP` protocol

This prevents unauthorized systems from attempting SSH access.

> **Note:** Replace `YOUR_PUBLIC_IP` with your actual public IP address.

---

# Step 5: Allow HTTP Access

Allow HTTP traffic on port `80`:

```bash
sudo ufw allow 80/tcp
```

### Explanation
This allows standard web traffic to access the server over HTTP.

---

# Step 6: Allow Traffic on Port 8000

Allow traffic on port `8000` for the Docker-based application:

```bash
sudo ufw allow 8000/tcp
```

### Explanation
This allows users to access the deployed Docker application using:

```bash
http://<server-ip>:8000
```

---

# Step 7: Enable the Firewall

After configuring all required rules, enable UFW:

```bash
sudo ufw enable
```

### Example Prompt

```bash
Command may disrupt existing ssh connections. Proceed with operation (y|n)?
```

Type:

```bash
y
```

and press **Enter**.

### Explanation
This warning appears because firewall changes can affect SSH access.  
Since SSH was already allowed from the required IP, it is safe to proceed.

---

# Step 8: Verify Firewall Rules

Check the configured firewall rules:

```bash
sudo ufw status numbered
```

### Example Output

```bash
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       49.205.100.25
80/tcp                     ALLOW       Anywhere
8000/tcp                   ALLOW       Anywhere
```

---

## Firewall Rule Explanation

| Port | Service | Access |
|------|---------|--------|
| 22   | SSH     | Allowed only from specific IP |
| 80   | HTTP    | Allowed from anywhere |
| 8000 | Docker App | Allowed from anywhere |

This confirms that the firewall is configured correctly.

---

# Step 9: Test Firewall Configuration

## 1. Test Port 8000 Access

The Docker application was tested using the browser:

```bash
http://<server-ip>:8000
```

### Example

```bash
http://13.60.92.28:8000
```

This successfully opened the deployed Docker web application, confirming that:

- Port `8000` is open
- Firewall allows access
- The application is reachable

---

## 2. Test Using curl

The application was also tested from the server using:

```bash
curl http://<server-ip>:8000
```

### Example

```bash
curl http://13.60.92.28:8000
```

### Example Output

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Docker Deployment</title>
</head>
<body>
    <h1>🚀 Successfully Deployed in Docker</h1>
</body>
</html>
```

This confirms that traffic on **port 8000** is successfully allowed through the firewall.

---

## 3. Verify SSH Restriction

The SSH firewall rule was verified using:

```bash
sudo ufw status numbered
```

The following rule confirms that SSH is allowed **only** from the specified public IP:

```bash
22/tcp   ALLOW   49.205.100.25
```

This restricts SSH access and improves server security.

---

# Important Note for AWS EC2

If this server is hosted on **AWS EC2**, firewall access must also be allowed in the **AWS Security Group**.

The following inbound rules should be configured:

| Type | Port | Source |
|------|------|--------|
| SSH | 22 | Your Public IP |
| HTTP | 80 | 0.0.0.0/0 |
| Custom TCP | 8000 | 0.0.0.0/0 |

This ensures that both:

- **UFW firewall**
- **AWS Security Group**

allow the required traffic.

---

# Conclusion

In this task, **UFW** was installed and configured to secure the Ubuntu server.  
The firewall was configured with the following rules:

- SSH access allowed **only from a specific IP address**
- HTTP access allowed on port `80`
- Docker application access allowed on port `8000`

This ensures that only required services are accessible while unauthorized access is restricted, resulting in a more secure server configuration.

---

# Key Commands Summary

```bash
sudo apt update
sudo apt install ufw -y

sudo ufw status

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow from YOUR_PUBLIC_IP to any port 22 proto tcp
sudo ufw allow 80/tcp
sudo ufw allow 8000/tcp

sudo ufw enable
sudo ufw status numbered

curl http://<server-ip>:8000
```