# Data Directory

This directory contains:
- DuckDB database files (`.duckdb`)
- Temporary data files
- Downloaded media (if applicable)

**Note**: All files in this directory are gitignored for security and size reasons.

## Database Files

- `conflict_monitor.duckdb` - Main database
- `conflict_monitor.duckdb.wal` - Write-ahead log (temporary)

## Backup

Regular backups are created in the `backups/` directory.
Run `make backup-db` to create a manual backup.
