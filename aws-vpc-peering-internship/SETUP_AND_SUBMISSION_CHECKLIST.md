# 📋 Internship Submission Checklist: Avhishek (Batch 1)

This project folder is directly on your Desktop!

---

### Step 1: AWS Setup & Screenshots (In your browser)
- [ ] Log in to AWS Console ([console.aws.amazon.com](https://console.aws.amazon.com)).
- [ ] Create `VPC-A` (`10.0.0.0/16`) and `VPC-B` (`10.1.0.0/16`).
  - 📸 **Screenshot 1** ➔ Save into `Desktop/aws-vpc-peering-internship/screenshots/01-vpc-creation.png`
- [ ] Create Peering Connection & Click **Accept request** (Status: `Active`).
  - 📸 **Screenshot 2** ➔ Save into `Desktop/aws-vpc-peering-internship/screenshots/02-peering-connection-active.png`
- [ ] Add the Peering route in both Route Tables (Target: `pcx-...`).
  - 📸 **Screenshot 3** ➔ Save into `Desktop/aws-vpc-peering-internship/screenshots/03-route-tables.png`
- [ ] Launch `Server-A` and `Server-B` (Free tier `t2.micro`).
- [ ] Connect to `Server-A` via EC2 Instance Connect and ping Server-B (`ping <Server-B-Private-IP>`).
  - 📸 **Screenshot 4** ➔ Save into `Desktop/aws-vpc-peering-internship/screenshots/04-ping-test-success.png`
- [ ] **Delete Resources:** Terminate both EC2 instances and delete VPCs so your AWS bill is $0.

---

### Step 2: Push to GitHub (In your browser)
- [ ] Go to [github.com/new](https://github.com/new).
- [ ] Set Repository Name: `aws-vpc-peering-internship`
- [ ] Select **Public**.
- [ ] Drag and drop this folder (`aws-vpc-peering-internship` from your Desktop) into GitHub!
- [ ] Copy your repository link: `https://github.com/<your-username>/aws-vpc-peering-internship`.

---

### Step 3: Submit Form
- [ ] Open the **Project Collection Form** link.
- [ ] Select **AWS Internship Batch 1**.
- [ ] Paste your GitHub link.
- [ ] Attach your Resume PDF.
- [ ] Click **Submit**!
