result=$(AWS_PROFILE=koko aws ecr describe-images --repository-name=$1 --region=$2 0>& 1)
if [ $? -eq 0  ]; then
imagedigest=$(echo $result | jq -r '.imageDetails[0].imageDigest')
echo -n "{\"success\":\"true\", \"imagedigest\":\"$imagedigest\", \"name\":\"$1\"}"
else
error_message=$(echo $result | jq -R -s -c '.')
echo -n "{\"success\":\"false\", \"error_message\": $error_message , \"name\":\"$1\"}"
fi


