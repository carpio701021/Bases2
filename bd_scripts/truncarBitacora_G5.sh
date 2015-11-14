#!/bin/bash
mv /var/log/mysql/mysql.log /var/log/mysql/backups/backupBitacoraG5_[$(date +%Y-%m-%d)].sql
mysqladmin flush-logs