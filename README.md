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

## Pre requisites

A GCP account with a GCP project on it.
Terraform installed on your machine.

## structure

### storage module

ressources to create a GCP bucket.
Also contain shell scripts to upload on the bucket.
The bucket will contain Elixir application releases, and startup/shutdown virtual machine scripts

instance-startup.sh script :

- prepare the file system (create directories etc)
- get VM instance metadata, some metadata are required (see beyond)
- copy the Elixir release from the bucket, unzip it and start it
- register the application on GCP service directory

instance-shutdown.sh script :

- unregister the application on GCP service directory

### network module

Create a network VPC and subnet for network isolation.
Add some firewall rules to allow the applications on the VPC to connect through erlang network protocols (EPMD and node distribution port)

Create a service directory namespace containing:

- one service
- one dns managed zone

The elixir application will register inside the directory namespace and service.

### compute module

Example of VM configuration terraform files to use the module.
