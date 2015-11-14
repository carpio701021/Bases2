#!/bin/bash
mysql -u root -p --execute='PURGE BINARY LOGS BEFORE NOW()'