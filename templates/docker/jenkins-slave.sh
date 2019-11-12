#!/bin/bash -x

# no_arguments=4

# if ! [ $# -eq $no_arguments ]
# then
#     echo "Script expects ${no_arguments} arguments i.e  ./${0##*/} USERNAME PASS" && exit 1
# fi

#"http://llgames-vault.westeurope.azurecontainer.io:8200"
# USER=$1
# USER_PASS=$2
# VAULT_ADDR=$3
# MASTER_URL=$4
export VAULT_ADDR



#Get Crumb
function get_crumb () {
    CRUMB=$( wget --user=admin --password=$1 --auth-no-challenge -q --output-document - "http://${MASTER_URL}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)")
    echo $CRUMB
}

#admin token

function vault_login () {
    vault login -method=userpass username=$USER password=$USER_PASS
    vault status
}

function get_admin_token () {
    ADMIN_TOKEN=$(vault kv  get -format=json secrets/jenkins | jq .data.admin_token | tr -d '"')
    echo $ADMIN_TOKEN
}

vault_login

TOKEN=$(get_admin_token)
CRUMB=$(get_crumb $TOKEN)
curl -o /home/jenkins/agent.jar  http://$MASTER_URL/jnlpJars/agent.jar

SECRET=$( curl -L -s -u admin:"${TOKEN}" -H "${CRUMB}" -X GET http://$MASTER_URL/computer/slave-linux/slave-agent.jnlp | sed "s/.*<application-desc main-class=\"hudson.remoting.jnlp.Main\"><argument>\([a-z0-9]*\).*/\1/" )
/usr/local/openjdk-8/bin/java -jar /usr/share/jenkins/agent.jar -jnlpUrl http://${MASTER_URL}/computer/slave-linux/slave-agent.jnlp -secret $SECRET -workDir "/var/jenkins_home/"

