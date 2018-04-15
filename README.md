# Prepare puppet master and client nodes

## Bake puppetmaster and node images

**Bake the puppetmaster image**
```
cd packer && project_id=$(gcloud info --format=flattened|grep config.project:|awk '{print $2}') ; \
zone=$(gcloud info --format=flattened|grep config.properties.compute.zone:|awk '{print $2}') ; \
packer build --var project_id=$project_id --var zone=${zone:-europe-west-1b} --var machine_type=g1-small  \
puppetmaster.json
```
**Bake the node image**
```
cd packer && project_id=$(gcloud info --format=flattened|grep config.project:|awk '{print $2}') ; \
zone=$(gcloud info --format=flattened|grep config.properties.compute.zone:|awk '{print $2}') ; \
packer build --var project_id=$project_id --var zone=${zone:-europe-west-1b} --var machine_type=g1-small  \
puppetnode.json
```

## Run the instances

```
cd terrafrom && terraform init && terraform apply
```

## Initial spinup puppet on server and nodes

Edit `inventory/gce.ini` first


If ansible-playbook is available in your path, this step will be done automatically (but still can fail, hahaha)

```
ansible-playbook -i inventory ansible-gce.yml
```


