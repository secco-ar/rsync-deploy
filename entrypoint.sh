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
$RSH -tt $DSN "cd $INPUT_REMOTE_PATH && run build"  
$RSH -tt $DSN "chown -R $INPUT_OWNER:$INPUT_OWNER $INPUT_REMOTE_PATH"
$RSH -tt $DSN "chmod $INPUT_PERMISSIONS -R $INPUT_REMOTE_PATH"
