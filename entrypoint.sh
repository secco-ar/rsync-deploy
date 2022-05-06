#!/bin/sh

# Inicia el agente SSH y carga la key.
source agent-start "$GITHUB_ACTION"
echo "$INPUT_REMOTE_KEY" | SSH_PASS="$INPUT_REMOTE_KEY_PASS" agent-add

# Agrega errores estrictos.
set -eu

# Variables.
SWITCHES="$INPUT_SWITCHES"
EXCLUDE_SWITCHES="--exclude='.git/' --exclude='.git*' --exclude='.github/'"
RSH="ssh -o StrictHostKeyChecking=no -p $INPUT_REMOTE_PORT $INPUT_RSH"
LOCAL_PATH="$GITHUB_WORKSPACE/$INPUT_PATH"
DSN="$INPUT_REMOTE_USER@$INPUT_REMOTE_HOST"

# Despliegue.
sh -c "rsync $SWITCHES $EXCLUDE_SWITCHES -e '$RSH' $LOCAL_PATH $DSN:$INPUT_REMOTE_PATH"
ssh -i /root/.ssh/id_rsa -tt $SSH_USER@$SSH_HOST "sudo chown -R apache:apache $LOCAL_PATH"
ssh -i /root/.ssh/id_rsa -tt $SSH_USER@$SSH_HOST "sudo chmod 775 -R $LOCAL_PATH"
