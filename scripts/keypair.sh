PROFILE_NAME=$("${BASH_SOURCE%/*}/profile_name.rb")
KEYPAIR_NAME=$("${BASH_SOURCE%/*}/random_phrase.rb")
KEYPAIR_FILENAME=~/.ssh/$KEYPAIR_NAME.pem

aws ec2 create-key-pair --profile=$PROFILE_NAME \
  --key-name $KEYPAIR_NAME \
  --query 'KeyMaterial' \
  --output text > $KEYPAIR_FILENAME

chmod 400 $KEYPAIR_FILENAME
${BASH_SOURCE%/*}/update_keypair_config.rb $KEYPAIR_NAME $KEYPAIR_FILENAME

echo "Successfully created new keypair at $KEYPAIR_FILENAME"
