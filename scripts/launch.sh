PROFILE_NAME=$("${BASH_SOURCE%/*}/profile_name.rb")

aws ec2 run-instances --profile=$PROFILE_NAME \
  --image-id ami-05c1fa8df71875112 \
  --count 1 \
  --instance-type t2.micro \
  --key-name $1
