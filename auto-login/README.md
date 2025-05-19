````markdown
# Auto-Login Script

This project provides automation for network login using Selenium and a network availability check.

## Contents

- `autologin`: A Python script that uses Selenium to log in to `http://acc.loongson.cn` automatically.
- `check-network`: A Bash script that checks network connectivity and triggers `autologin` if the connection fails.

## Requirements

Ensure the following packages are installed:

```bash
sudo apt-get install python3-selenium
sudo apt-get install lbrowserdriver
````

Also ensure that your system has a graphical session available at `DISPLAY=:0`.

> **Note**: The Chrome driver is assumed to be located at `/usr/bin/lbrowserdriver`.

## Usage

1. **Make scripts executable**:

```bash
chmod +x autologin check-network
```

2. **Run network check manually**:

```bash
./check-network
```

If the target host is unreachable, it will attempt to auto-login.

## Cron Job Setup

To run the `check-network` script every day at **7:30 AM** and log output to a `log` directory:

### Step 1: Create the log directory

```bash
mkdir -p /home/usr/auto-login/log
```

### Step 2: Add to crontab

Edit your crontab:

```bash
crontab -e
```

Add the following line:

```cron
30 7 * * * /home/usr/bin/auto-login/check-network >> /home/usr/auto-login/log/autologin.log 2>&1
```

This will append all output and errors to `autologin.log`.

## Log Cleanup (Optional)

To clean up the log file every 7 days, add the following line to your crontab:

```cron
0 0 */7 * * rm -f /home/usr/auto-login/log/autologin.log
```

> Modify the retention policy as needed (e.g., keep rotating logs by date).

## Notes

* The login page structure (e.g., iframe name or button ID) must match the script; update the script if the page changes.
* Headless mode is enabled by default. If you encounter issues, try removing the `--headless` option in `autologin`.

---

