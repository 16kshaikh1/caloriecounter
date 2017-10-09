#!/bin/bash
# create build package for Lex chatbot, stage in s3 bucket, and deploy package.

# create temp zip file with all the json data objects
zip foodbot.zip lambda.js foods.json drinks.json

# copy the build file and source files to a staging bucket in case need for research
aws s3 cp lambda.js s3://fastfoodchatbot/binaries/
aws s3 cp foodbot.zip s3://fastfoodchatbot/binaries/
aws s3 cp foods.json s3://fastfoodchatbot/binaries/
aws s3 cp drinks.json s3://fastfoodchatbot/binaries/

# cleanup temporary file
echo 'removed temp file'
rm foodbot.zip

# update the lambda function with the binaries that have been staged
aws lambda update-function-code --function-name myCalorieCounterGreen --s3-bucket fastfoodchatbot --s3-key binaries/foodbot.zip

# wrap-up
echo 'completed new deployment'
