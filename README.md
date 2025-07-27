# Ansible Automation with Terraform-Provisioned Infrastructure

This repository automates the provisioning and configuration of multiple Linux servers using **Terraform** and **Ansible**. The infrastructure comprises 4 EC2-based servers (1 master + 3 clients), organized under `dev` and `prod` environments.

---

##  Infrastructure Overview

* **Provisioning Tool**: Terraform
* **Configuration Management**: Ansible
* **Cloud Provider**: AWS (EC2 instances)
* **Workspaces**:

  * `dev` – development environment
  * `prod` – production environment
* **Total EC2 Instances**: 4 (1 control node, 3 managed nodes)

---

##  Repository Structure

```
ansible-js/
├── inventories/
│   ├── dev           # Hosts under development environment
│   └── prod          # Hosts under production environment
└── playbooks/
    └── install_docker.yml   # Playbook to install Docker
```

---

##  Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/kaffie-1517/ansible-js.git
cd ansible-js
```

### 2️⃣ Setup Ansible (if not installed)

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

---

### 3️⃣ Configure Inventory

Inventory files are located under the `inventories/` directory:

* Example structure inside `dev` or `prod`:

```
[servers]
server1 ansible_host=YOUR_SERVER_1 ansible_user=ubuntu ansible_ssh_private_key_file=~/keys/my-key-2o.pem
server2 ansible_host=YOUR_SERVER_2 ansible_user=ubuntu ansible_ssh_private_key_file=~/keys/my-key-2o.pem
server3 ansible_host=YOUR_SERVER_3 ansible_user=ubuntu ansible_ssh_private_key_file=~/keys/my-key-2o.pem
```

Update IPs and paths as per your setup.

---

### 4️⃣ Verify Ansible Connectivity

```bash
ansible -i inventories/dev servers -m ping
```

Expected Output:

```
server1 | SUCCESS => {...}
server2 | SUCCESS => {...}
server3 | SUCCESS => {...}
```

---

### 5️⃣ Run Playbooks

Install Docker on all servers:

```bash
ansible-playbook -i inventories/dev playbooks/install_docker.yml
```

Repeat for `prod` if needed by changing the inventory.

---

##  Example Ad-Hoc Commands

Check Docker version:

```bash
ansible -i inventories/dev servers -a "docker --version"
```

Check memory usage:

```bash
ansible -i inventories/dev servers -a "free -h"
```

Start/Stop services:

```bash
ansible server2 -a "sudo systemctl start nginx"
ansible server2 -a "sudo systemctl stop nginx"
```

---

##  SSH Key Permissions

Make sure your key has the correct permissions:

```bash
chmod 400 ~/keys/my-key-2o.pem
```

---

##  Terraform Integration (High-Level)

* Terraform was used to spin up the infrastructure with named workspaces:

  * `terraform workspace select dev`
  * `terraform workspace select prod`

* Each workspace provisions respective EC2 instances and outputs their IPs, which you can use to update your Ansible inventories.

---

##  Git Usage Notes

Since GitHub now requires **token-based authentication**, make sure to:

1. Use **HTTPS + Personal Access Token (PAT)** or switch to **SSH**.
2. If using HTTPS:

   ```bash
   git remote set-url origin https://<username>:<your_token>@github.com/kaffie-1517/ansible-js.git
   ```

   Replace `<username>` and `<your_token>` accordingly.

---

##  TODO

* [ ] Add `nginx` install playbook
* [ ] Integrate Terraform output directly into Ansible inventory
* [ ] Add tagging to EC2 for auto-grouping
* [ ] Add CI/CD pipeline using GitHub Actions (optional)

---

## 👨‍💻 Author

**Kaffie-1517**
📧 Reach me on GitHub or drop a message if you’d like to collaborate!
