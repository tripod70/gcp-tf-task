# Creating GCP entities with Terraform
## test task
---
**inputs:**

- project_id           []
- region               [us-central1]
- zone                 [us-central1-c]
- vpc_network_name     [net-00]
- vpc_subnetwork_name  [subnet-00]
- ip_cidr_range        []
- firewall_src_ranges  []
- gce_instance_name  <span style="color:blue"> - prompted always</span>
- gce_instance_type    [e2-micro]
- sa_name              [sa-tech]
- roles                ["roles/cloudconfig.serviceAgent","roles/iam.serviceAccountUser"]
---
**outputs:**
- private_key           - masked
- decoded_private_key   - masked
- public_ip          
- sa_email              - for get from remote state
