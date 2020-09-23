#!/bin/sh
set -ex

# get vm attribute from GCP instance metadata
getVmAttribute() {
    path=$1; shift;
    echo `curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/${path}`
}

# get project attributes from GCP instance metadata
getProjectAttribute() {
    path=$1; shift;
    echo `curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/${path}`
}

# export a variable
variableExport() {
    attribute=$1; shift;
    value=$1; shift;
    eval "export ${attribute}=${value}"
}

# prepare file system
export HOME=/app
rm -rf ${HOME} || true
mkdir -p ${HOME}
cd ${HOME}

# get usefull metadatas from instance
variableExport "INSTANCE_NAME" `getVmAttribute "name"`
variableExport "INTERNAL_IP" `getVmAttribute "network-interfaces/0/ip"`
variableExport "SERVICE_NAMESPACE" `getVmAttribute "attributes/service-namespace"`
variableExport "RELEASE_URL" `getVmAttribute "attributes/release-url"`
variableExport "SECRET_KEY_BASE" `getVmAttribute "attributes/secret-key-base"`
variableExport "SERVICE_NAME" `getVmAttribute "attributes/service-name"`
variableExport "REGION" `getVmAttribute "attributes/region"`
variableExport "CLUSTER_HOSTNAME" `getVmAttribute "attributes/cluster-hostname"`
variableExport "PREEMPTIBLE" `getVmAttribute "scheduling/preemptible"`
variableExport "PROJECT" `getProjectAttribute "project-id"`
variableExport "NODE_NAME" "${SERVICE_NAME}@${INTERNAL_IP}"


# copy release from bucket untar the release and clean
gsutil cp ${RELEASE_URL} ${HOME}/release.tar.gz
# untar and delete archive
tar -zxf release.tar.gz
rm release.tar.gz
# extract the name of the binary
variableExport "RELEASE_NAME" `ls -t ${HOME}/bin | head -n 1`
# make the binary executable
chmod 755 ${HOME}/bin/${RELEASE_NAME}


# create the gcp service directory endpoint
gcloud beta service-directory endpoints create ${INSTANCE_NAME} \
   --address ${INTERNAL_IP} \
   --port 80 \
   --metadata erlang_node=${NODE_NAME} \
   --service ${SERVICE_NAME} \
   --namespace ${SERVICE_NAMESPACE} \
   --location ${REGION}

# run the application
PORT=80 ${HOME}/bin/${RELEASE_NAME} start