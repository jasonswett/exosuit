aws ec2 run-instances --profile personal \
  --image-id ami-05c1fa8df71875112 \
  --count 1 \
  --instance-type t2.micro \
  --key-name magic-screaming-thing
