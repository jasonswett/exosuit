KEYPAIR_NAME=KeyPair7
KEYPAIR_FILENAME=~/exo.pem

aws ec2 create-key-pair --profile personal \
  --key-name $KEYPAIR_NAME \
  --query 'KeyMaterial' \
  --output text > $KEYPAIR_FILENAME

echo "Successfully created new keypair at $KEYPAIR_FILENAME"
