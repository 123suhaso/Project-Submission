# Task 1 - Server Setup and SSH Configuration using AWS EC2

## Objective
Provision a Linux server using AWS EC2 and configure secure SSH access using SSH key-based authentication without password login.

## Expected Outcome
Secure remote access to the EC2 Linux server using SSH keys without entering a password.

---

## Project Files

- `README.md` → Documentation for the setup
- `setup_ssh_ec2.sh` → Script to configure SSH key-based login and secure SSH settings

---

## Prerequisites

Before starting, make sure you have:

- An AWS account
- Access to AWS EC2 Console
- A Linux EC2 instance (Ubuntu recommended)
- Your downloaded EC2 key pair file (`.pem`)
- SSH client installed on your system

---

## Step 1 - Launch EC2 Instance

1. Log in to AWS Console  
2. Go to **EC2**  
3. Click **Launch Instance**  
4. Choose:
   - **AMI**: Ubuntu Server 22.04 LTS
   - **Instance Type**: `t2.micro` or `t3.micro`
5. Create a key pair:
   - **Name**: `linux-server-key`
   - **Type**: RSA
   - **Format**: `.pem`
6. Configure Security Group:
   - Allow **SSH (port 22)** from **My IP**
7. Launch the instance

---

## Step 2 - Get Instance Public IP

1. Open the EC2 instance  
2. Copy the **Public IPv4 address**

**Example:**
```text
13.233.100.25
```

---

## Step 3 - Connect to EC2 Using the Downloaded PEM Key

### For Ubuntu EC2

Run this on your local machine:

```bash
ssh -i linux-server-key.pem ubuntu@<EC2-PUBLIC-IP>
```

**Example:**

```bash
ssh -i linux-server-key.pem ubuntu@13.233.100.25
```

If this is your first login, type:

```text
yes
```

You should now be connected to your EC2 Linux server.

---

## Step 4 - Generate Your Own SSH Key Pair on Local Machine

Run this on your local machine:

```bash
ssh-keygen -t rsa -b 4096 -C "my-ec2-login-key"
```

Press **Enter** for the default file location.

This creates:

**Private key:**
```text
~/.ssh/id_rsa
```

**Public key:**
```text
~/.ssh/id_rsa.pub
```

---

## Step 5 - Display Your Public Key

Run this on your local machine:

```bash
cat ~/.ssh/id_rsa.pub
```

Copy the full output.

**Example:**

```text
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQ... my-ec2-login-key
```

You will paste this into the EC2 server in the next step.

---

## Step 6 - Upload the Configuration Script to EC2

From your local machine, upload the script:

```bash
scp -i linux-server-key.pem setup_ssh_ec2.sh ubuntu@<EC2-PUBLIC-IP>:/home/ubuntu/
```

**Example:**

```bash
scp -i linux-server-key.pem setup_ssh_ec2.sh ubuntu@13.233.100.25:/home/ubuntu/
```

---

## Step 7 - Run the Configuration Script on EC2

SSH into the instance again:

```bash
ssh -i linux-server-key.pem ubuntu@<EC2-PUBLIC-IP>
```

Make the script executable:

```bash
chmod +x setup_ssh_ec2.sh
```

Run the script:

```bash
./setup_ssh_ec2.sh
```

When prompted:

- Paste your copied public key from **Step 5**
- Press **Enter**

This script will:

- Create the `.ssh` folder
- Add your public key to `authorized_keys`
- Set proper permissions
- Enable key-based authentication
- Disable password login
- Disable root login
- Restart SSH service

---

## Step 8 - Test Passwordless SSH Login

Exit from EC2:

```bash
exit
```

Now test login using your own SSH key:

```bash
ssh -i ~/.ssh/id_rsa ubuntu@<EC2-PUBLIC-IP>
```

**Example:**

```bash
ssh -i ~/.ssh/id_rsa ubuntu@13.233.100.25
```

If it logs in without asking for a password, then passwordless SSH login is successfully configured.

---

## Step 9 - Verify SSH Configuration

After logging in again, run:

```bash
sudo grep -E 'PasswordAuthentication|PubkeyAuthentication|PermitRootLogin' /etc/ssh/sshd_config
```

**Expected output:**

```text
PubkeyAuthentication yes
PasswordAuthentication no
PermitRootLogin no
```

Now check `.ssh` permissions:

```bash
ls -ld ~/.ssh
ls -l ~/.ssh/authorized_keys
```

**Expected output:**

```text
drwx------ ~/.ssh
-rw------- ~/.ssh/authorized_keys
```

---

## Final Result

The EC2 Linux server is now configured with:

- Secure SSH remote access
- SSH key-based authentication
- Passwordless login
- Disabled password-based SSH access
- Disabled root SSH login