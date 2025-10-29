#!/bin/bash

BACKUP_DIR="backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DB_FILE="data/conflict_monitor.duckdb"
BACKUP_FILE="$BACKUP_DIR/conflict_monitor_$TIMESTAMP.duckdb"

# Create backup directory
mkdir -p $BACKUP_DIR

# Check if database exists
if [ ! -f "$DB_FILE" ]; then
    echo "Database file not found: $DB_FILE"
    exit 1
fi

# Copy database
echo "Creating backup..."
cp $DB_FILE $BACKUP_FILE

# Compress
echo "Compressing backup..."
gzip $BACKUP_FILE

echo "Backup created: ${BACKUP_FILE}.gz"

# Keep only last 7 backups
echo "🧹 Cleaning old backups..."
ls -t $BACKUP_DIR/*.gz | tail -n +8 | xargs -r rm

echo "Backup complete!"
```

