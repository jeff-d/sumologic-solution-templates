#!/bin/sh

echo "Start S3 upload Script....."

declare -a regions=("us-east-2" "us-east-1" "us-west-1" "us-west-2" "ap-south-1" "ap-northeast-2" "ap-southeast-1" "ap-southeast-2" "ap-northeast-1" "ca-central-1" "eu-central-1" "eu-west-1" "eu-west-2" "eu-west-3" "eu-north-1s" "sa-east-1" "ap-east-1s" "af-south-1s" "eu-south-1" "me-south-1s")

cd ..\/

for region in "${regions[@]}"
do
    bucket_name=appdevzipfiles-$region

    if [[ `echo ${region} | awk '{print substr($0,length,1)}'` == "s" ]]
    then
        export region=`echo "${region%?}"`
    fi
    echo "Region is $region and Bucket Name is $bucket_name"
    aws s3 cp . s3://$bucket_name/sumologic-aws-observability/ --region ${region} --recursive --exclude '*.sh' --exclude '*.json' --exclude '.git/*' --exclude '.idea/*' --acl public-read
done

cd templates/

#aws s3 cp sumologic_observability.master.template.yaml s3://sumologic-appdev-aws-sam-apps/ --acl public-read

echo "End S3 upload Script....."