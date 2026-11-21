
#!/bin/bash

# Automated Remote Backup Script

SOURCE_DIR="$1"
REMOTE_USER="$2"
REMOTE_HOST="$3"
REMOTE_DIR="$4"

BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
TEMP_DIR="/tmp"
BACKUP_PATH="$TEMP_DIR/$BACKUP_NAME"
LOG_FILE="$HOME/backup_report.log"

# Function to generate report
report() {
    echo "[$(date)] $1" | tee -a "$LOG_FILE"
}


echo "AUTOMATED BACKUP SYSTEM"


# Validate arguments
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <source_directory> <remote_user> <remote_host> <remote_directory>"
    exit 1
fi

# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    report "FAILED: Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Check required commands
for cmd in tar ssh scp; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        report "FAILED: Required command not installed: $cmd"
        exit 1
    fi
done

report "Starting backup of $SOURCE_DIR"

# Create compressed backup
if ! tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"; then
    report "FAILED: Could not create backup archive"
    rm -f "$BACKUP_PATH"
    exit 1
fi

report "Backup archive created: $BACKUP_PATH"

# Create remote directory
if ! ssh -o BatchMode=yes -o ConnectTimeout=10 \
    "$REMOTE_USER@$REMOTE_HOST" "mkdir -p '$REMOTE_DIR'"; then
    report "FAILED: Could not connect to remote server"
    rm -f "$BACKUP_PATH"
    exit 1
fi

# Transfer backup
if scp -o BatchMode=yes "$BACKUP_PATH" \
    "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"; then

    # Verify remote file exists and has non-zero size
    if ssh -o BatchMode=yes "$REMOTE_USER@$REMOTE_HOST" \
        "test -s '$REMOTE_DIR/$BACKUP_NAME'"; then

        report "SUCCESS: Backup transferred and verified"
        report "Remote location: $REMOTE_HOST:$REMOTE_DIR/$BACKUP_NAME"
        rm -f "$BACKUP_PATH"
        report "Temporary backup removed"
        exit 0
    fi
fi

report "FAILED: Backup transfer or verification failed"
report "Local backup retained at: $BACKUP_PATH"
exit 1
