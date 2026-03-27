# Task 4: Secure Monitoring Logs by Restricting Access to a Dedicated User

## Objective
The objective of this task is to secure the monitoring logs by:

- Creating a **dedicated user** for monitoring operations
- Assigning ownership of the monitoring directory to that user
- Providing **full access** only to the monitoring user
- Restricting access for all other users
- Verifying access control

The monitoring directory used in this task is:

```bash
/opt/container-monitor
```

---

## Expected Outcome
- A dedicated monitoring user is created
- The monitoring directory is securely owned by that user
- Only the monitoring user can access monitoring files
- Other users are denied access

---

# Step 1: Create a Dedicated User

Create a dedicated user named `suhas`:

```bash
sudo useradd -m suhas
```

### Explanation
- `useradd` → Creates a new user
- `-m` → Creates a home directory for the user

---

## Set Password for the User

```bash
sudo passwd suhas
```

This allows login access for the newly created user.

---

# Step 2: Verify the User

Check whether the user was created successfully:

```bash
id suhas
```

### Output

```bash
ubuntu@ip-172-31-39-151:~$ id suhas
uid=1001(suhas) gid=1001(suhas) groups=1001(suhas)
```

This confirms that the dedicated monitoring user was created successfully.

---

# Step 3: Create Monitoring Directory

Create the required monitoring directory:

```bash
sudo mkdir -p /opt/container-monitor
```

### Explanation
- `mkdir` → Creates a directory
- `-p` → Creates parent directories if they do not already exist

---

# Step 4: Assign Ownership to Monitoring User

Assign ownership of the monitoring directory to the `suhas` user:

```bash
sudo chown -R suhas:suhas /opt/container-monitor
```

### Explanation
- `chown` → Changes file/directory ownership
- `-R` → Applies recursively to all files and subdirectories
- `suhas:suhas` → Sets both the **owner** and **group**

This ensures that the monitoring directory is fully controlled by the dedicated user.

---

# Step 5: Give Full Access to Monitoring User

Restrict permissions so that only the monitoring user has access:

```bash
sudo chmod -R 700 /opt/container-monitor
```

---

## Permission Explanation

```bash
700
```

| User Type | Permission |
|-----------|------------|
| Owner     | Read + Write + Execute |
| Group     | No access |
| Others    | No access |

This means:

- **suhas** → Full access
- **All other users** → No access

---

# Step 6: Verify Ownership

Check the ownership and permissions of the directory:

```bash
ls -ld /opt/container-monitor
```

### Output

```bash
ubuntu@ip-172-31-39-151:~$ ls -ld /opt/container-monitor
drwx------ 3 suhas suhas 4096 Mar 27 12:48 /opt/container-monitor
```

### Explanation
- `drwx------` → Only the owner has access
- `suhas suhas` → Owner and group are both `suhas`

This confirms that the directory is securely configured.

---

# Step 7: Verify Access as Monitoring User

Switch to the monitoring user:

```bash
su - suhas
```

Then access the monitoring directory:

```bash
cd /opt/container-monitor
ls
```

### Output

```bash
suhas@ip-172-31-39-151:/opt/container-monitor$ cd /opt/container-monitor
suhas@ip-172-31-39-151:/opt/container-monitor$ ls
logs  monitor.sh
```

This confirms that the dedicated monitoring user has access to the directory.

---

## Verify Log File Access

Move into the logs directory and read the monitoring log:

```bash
cd /opt/container-monitor/logs
cat container_usage.log
```

### Output

```bash
2026-03-27 13:07:54 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:08:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:09:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:10:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:11:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:12:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:13:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:14:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:15:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:16:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:17:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:18:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:19:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:20:02 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:21:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:22:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:23:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:24:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:25:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:26:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:27:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:28:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:29:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:30:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:31:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:32:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:33:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
2026-03-27 13:34:01 IST | Container: docker-web-container | CPU: 0.00% | Memory:  3.426MiB / 3.727GiB
```

This confirms that the dedicated monitoring user can successfully access and read the monitoring logs.

---

# Step 8: Verify Access Restriction

Now test access from another user (`ravi`):

```bash
su - ravi
cd /opt/container-monitor
```

### Output

```bash
ubuntu@ip-172-31-39-151:~$ su - ravi
Password:
ravi@ip-172-31-39-151:~$ cd /opt/container-monitor
-bash: cd: /opt/container-monitor: Permission denied
```

This confirms that **other users are restricted** from accessing the monitoring directory.

---

# Conclusion

In this task, a dedicated user named `suhas` was created for monitoring operations.  
The `/opt/container-monitor` directory was assigned to this user and secured using strict file permissions (`700`), ensuring:

- Full access for the monitoring user
- No access for group users
- No access for all other users

This successfully protects the monitoring logs from unauthorized access.

---

# Key Commands Summary

```bash
sudo useradd -m suhas
sudo passwd suhas

id suhas

sudo mkdir -p /opt/container-monitor

sudo chown -R suhas:suhas /opt/container-monitor
sudo chmod -R 700 /opt/container-monitor

ls -ld /opt/container-monitor

su - suhas
cd /opt/container-monitor
ls

cd /opt/container-monitor/logs
cat container_usage.log

su - ravi
cd /opt/container-monitor
```