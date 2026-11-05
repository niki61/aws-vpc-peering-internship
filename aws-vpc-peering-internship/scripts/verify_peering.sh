#!/bin/bash
# ==============================================================================
# Script: verify_peering.sh
# Purpose: Verifies bidirectional connectivity across the AWS VPC Peering link
# ==============================================================================

TARGET_IP=$1

if [ -z "$TARGET_IP" ]; then
  echo "Usage: $0 <Private-IP-of-Target-EC2-Instance>"
  echo "Example: $0 10.1.1.185"
  exit 1
fi

echo "=========================================================="
echo " Starting VPC Peering Ping Verification Test"
echo " Target Private IP: $TARGET_IP"
echo " Timestamp: $(date)"
echo "=========================================================="

# Run 4 ICMP ping packets with 1 second timeout each
ping -c 4 "$TARGET_IP"

if [ $? -eq 0 ]; then
  echo ""
  echo ">>> [SUCCESS]: VPC Peering connection is ACTIVE and routing traffic successfully!"
else
  echo ""
  echo ">>> [FAILURE]: Could not reach $TARGET_IP. Please check Route Tables and Security Group ICMP rules."
fi
