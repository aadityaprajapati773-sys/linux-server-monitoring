# Linux Server Monitoring & Auto-Healing

## Project Overview

## Architecture
EC2
 ↓
Bash Script
 ↓
CPU / Memory / Disk
 ↓
Service Health Check
 ↓
Auto-Healing
 ↓
Logs
 ↓
AWS CLI
 ↓
S3

## How It Works
                AWS EC2
                  │
                  ↓
           monitoring.sh
                  │
        ┌─────────┼─────────┐
        ↓         ↓         ↓
       CPU      Memory     Disk
        │         │         │
        └─────────┼─────────┘
                  ↓
             Check Nginx
                  │
            ┌─────┴─────┐
            ↓           ↓
         Running       Down
            │           │
            ↓           ↓
         Continue    Restart Nginx
                        │
                        ↓
                    Log Event
                        │
                        ↓
                   AWS S3 Bucket

## Installation

## Configuration

## Testing

## AWS S3 Integration

## Cron Automation

## Screenshots

## Future Improvements
