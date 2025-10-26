reg_name='flux-registry'

if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then    
  docker run \
    -d --restart=always --name "${reg_name}" -p 5000:5000\
    registry:2
fi

