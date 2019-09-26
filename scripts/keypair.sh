KEYPAIR_NAME=$("${BASH_SOURCE%/*}/random_phrase.rb")
KEYPAIR_FILENAME=~/.ssh/$KEYPAIR_NAME.pem

aws ec2 create-key-pair --profile personal \
  --key-name $KEYPAIR_NAME \
  --query 'KeyMaterial' \
  --output text > $KEYPAIR_FILENAME

echo "Successfully created new keypair at $KEYPAIR_FILENAME"
