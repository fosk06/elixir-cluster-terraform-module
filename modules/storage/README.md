# Storage ressources

Create the GCP storage ressources:

- one bucket to store the releases and the VM startup/shutdown scripts
- the VM startup/shutdown scripts

## startup script

the script script will download the elixir release with gsutil then unzip it and lauch it.
Then it will register the application endpoint on the GCP service directory.

## shutdown script

the script script will un register on the GCP service directory.