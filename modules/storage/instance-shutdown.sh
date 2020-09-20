#!/bin/sh
set -ex

# get vm attribute
getVmAttribute() {
    path=$1; shift;
    echo `curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/${path}`
}

# get project attributes
getProjectAttribute() {
    path=$1; shift;
    echo `curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/${path}`
}

# export a variable
variableExport() {
    attribute=`echo $1 | tr '[:lower:]' '[:upper:]'`; shift;
    value=$1; shift;
    eval "export ${attribute}=${value}"
}

# get usefull metadatas from instance
variableExport "INSTANCE_NAME" `getVmAttribute "name"`
variableExport "SERVICE_NAMESPACE" `getVmAttribute "attributes/service-namespace"`
variableExport "RELEASE_NAME" `getVmAttribute "attributes/release-name"`
variableExport "SERVICE_NAME" `getVmAttribute "attributes/service-name"`
variableExport "REGION" `getVmAttribute "attributes/region"`
variableExport "PROJECT" `getProjectAttribute "project-id"`


# create the gcp service directory endpoint
gcloud beta service-directory endpoints delete ${INSTANCE_NAME} \
   --service ${SERVICE_NAME} \
   --namespace ${SERVICE_NAMESPACE} \
   --location ${REGION}

# stop the application
PORT=80 ${HOME}/bin/${RELEASE_NAME} stop