#!/bin/bash
ARCH="backup_grupo5_[$(date +%Y-%m-%d)].sql"
mysqldump -u root -p OutGuat > $ARCH