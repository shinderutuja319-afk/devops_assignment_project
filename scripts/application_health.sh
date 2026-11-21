
#!/bin/bash

# Application Health Check Script

URL="${1:-https://wise-demo.duckdns.org}"
TIMEOUT=10
LOG_FILE="$HOME/application_health.log"

echo "APPLICATION HEALTH CHECK"

echo "Application URL: $URL"
echo "Check Time: $(date)"
echo ""

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is not installed."
    exit 2
fi

HTTP_CODE=$(curl -L -s -o /dev/null \
    -w "%{http_code}" \
    --connect-timeout "$TIMEOUT" \
    --max-time "$TIMEOUT" \
    "$URL")

CURL_STATUS=$?

if [ "$CURL_STATUS" -eq 0 ] &&
   [[ "$HTTP_CODE" =~ ^2[0-9][0-9]$ ]]; then

    STATUS="UP"
    echo "Application Status: UP"
    echo "HTTP Status Code: $HTTP_CODE"
    echo "Application is responding successfully."

    echo "[$(date)] UP - $URL - HTTP $HTTP_CODE" >> "$LOG_FILE"
    exit 0

else
    STATUS="DOWN"
    echo "Application Status: DOWN"
    echo "HTTP Status Code: ${HTTP_CODE:-000}"
    echo "Application is unavailable or not responding."

    echo "[$(date)] DOWN - $URL - HTTP ${HTTP_CODE:-000}" >> "$LOG_FILE"
    exit 1
fi
