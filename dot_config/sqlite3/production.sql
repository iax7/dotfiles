-- SQLite Production Configuration
-- Official docs: https://www.sqlite.org/pragma.html
-- This file contains SAFE settings optimized for production use
-- Usage: alias sqlite3-prod='sqlite3 -init ~/.iax/config/sqlite3/production.sql'
--        sqlite3 database.db ".read production.sql"
--        sqlite3 -init production.sql mydb.db

-- Suppress output during setup
.output /dev/null

-- CRITICAL: Safety and Durability Settings
PRAGMA synchronous = FULL;           -- Ensure data is fully written to disk (safest, prevents corruption)
PRAGMA foreign_keys = ON;            -- Enforce referential integrity (MUST be ON in production)
PRAGMA journal_mode = WAL;           -- Write-Ahead Logging for better concurrency and crash recovery
PRAGMA wal_autocheckpoint = 1000;    -- Checkpoint WAL file every 1000 pages (prevents WAL from growing too large)
PRAGMA busy_timeout = 5000;          -- Wait up to 5 seconds when database is locked (prevents immediate failures)

-- Performance Settings (Conservative)
PRAGMA locking_mode = NORMAL;        -- Allow concurrent access (multiple readers, one writer)
PRAGMA cache_size = -2000;           -- 2MB cache (negative means KB; adjust based on available memory)
PRAGMA temp_store = MEMORY;          -- Store temporary tables in memory for better performance
PRAGMA mmap_size = 268435456;        -- 256MB memory-mapped I/O (improves read performance)
PRAGMA page_size = 4096;             -- Standard page size (optimal for most systems)

-- Query Optimization
PRAGMA optimize;                     -- Optimize database (run periodically in production)
PRAGMA analysis_limit = 1000;        -- Limit ANALYZE to 1000 rows per index (faster analysis)

-- Security Settings
PRAGMA secure_delete = ON;           -- Overwrite deleted data (important for sensitive data)
PRAGMA auto_vacuum = INCREMENTAL;    -- Gradual space reclamation (prevents large vacuum operations)

-- Restore output
.output stdout

-- Display Settings
.headers on
.mode box
.nullvalue NULL
.timer on
.width auto                          -- Auto-adjust column widths

-- Production prompt
.prompt "sqlite-prod> " "        ...> "

-- Startup message
.print '╔══════════════════════════════════════╗'
.print '║ SQLite PRODUCTION Configuration      ║'
.print '╚══════════════════════════════════════╝'
.print ''
.print 'Active PRAGMAs:'
.print '  • synchronous = FULL (maximum safety)'
.print '  • foreign_keys = ON (referential integrity)'
.print '  • journal_mode = WAL (crash recovery + concurrency)'
.print '  • busy_timeout = 5000ms (retry on locks)'
.print '  • secure_delete = ON (data security)'
.print ''
.print 'Monitoring commands:'
.print '  PRAGMA wal_checkpoint(PASSIVE);  - Checkpoint WAL file'
.print '  PRAGMA integrity_check;          - Check database integrity'
.print '  PRAGMA foreign_key_check;        - Verify FK constraints'
.print '  PRAGMA optimize;                 - Optimize query planner'
.print '  PRAGMA incremental_vacuum(N);    - Reclaim N pages'
.print ''
.print 'Database info:'
PRAGMA wal_checkpoint(PASSIVE);      -- Run initial checkpoint
.print ''
.print 'Ready for production queries.'
.print ''
