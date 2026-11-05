# Project Screenshots Directory

Please drop your 4 AWS Console / Terminal verification screenshots into this folder:

1. `01-vpc-creation.png`
   - **What to show:** AWS Console -> VPC -> "Your VPCs" page displaying both `VPC-A` and `VPC-B` with their respective CIDRs (`10.0.0.0/16` and `10.1.0.0/16`).
   
2. `02-peering-connection-active.png`
   - **What to show:** AWS Console -> VPC -> "Peering connections" page showing status **Active**.

3. `03-route-tables.png`
   - **What to show:** AWS Console -> VPC -> "Route tables" page showing the peering route (Destination: `10.1.0.0/16` or `10.0.0.0/16`, Target: `pcx-...`).

4. `04-ping-test-success.png`
   - **What to show:** Terminal screen (EC2 Instance Connect) connected to `Server-A` running `ping <Server-B-Private-IP>` with 0% packet loss.
