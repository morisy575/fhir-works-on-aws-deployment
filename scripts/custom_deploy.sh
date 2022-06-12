export PACKAGE_ROOT=${PWD%/*}
IAMUserARN=$(aws sts get-caller-identity --query "Arn" --output text)

#TODO: how to stop if not all test cases passed?
yarn add serverless-better-credentials
# yarn install --frozen-lockfile
# yarn run release
# yarn add serverless

touch serverless_config.json
if ! grep -Fq "devAwsUserAccountArn" serverless_config.json; then
    echo "{\n  \"devAwsUserAccountArn\": \"$IAMUserARN\"\n}" >> serverless_config.json
fi

## Deploy to stated region
yarn run serverless-deploy --verbose --region us-east-1 --stage dev || { echo >&2 "Failed to deploy serverless application."; exit 1; }