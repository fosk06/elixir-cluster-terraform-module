# elixir cluster terraform module

This project is a terraform module that allows you to deploy an elixir application as a cluster of nodes on Google Cloud Platform.

It creates the following ressources on GCP:

- private vpc
- firewall rules
- Service directory (beta feature of GCP)
- DNS managed zone
- bucket to store elixir releases and virtual machine scripts
- startup script and shutdown script for VM
- VM template
- VM target pool using the VM template
- (optional) default autoscaler
