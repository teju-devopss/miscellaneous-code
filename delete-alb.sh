# shellcheck disable=SC2046
aws elbv2 delete-load-balancer --load-balancer-arn $(aws elbv2 describe-load-balancers | grep LoadBalancerArn | grep tools | awk '{print $2}' | sed -e 's/,//' |xargs)