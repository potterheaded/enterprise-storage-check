## Enterprise Storage Check

This repository to allow partners to perform a storage check against GitHub Enterprise Server, without having to install a complete GitHub Enterprise Server instance.

Currently covered:
- Actions Artifacts and Logs
- Direct download links from the storage, used for Artifact Cache

Currently not covered:
- Packages
- OIDC authentication based storage check

This test is for checking compatibility only, and will not run any scale testing.

## Permissions used

The current permissions used are covered in the GitHub [documentation](https://docs.github.com/en/enterprise-server/admin/github-actions/enabling-github-actions-for-github-enterprise-server/enabling-github-actions-with-amazon-s3-storage), and map to APIs within [AWS](https://docs.aws.amazon.com/s3/index.html). 

## Usage

You can use this repository as a codespace, or locally using the following commands.

**To test Actions Artifacts and Logs:**

```
docker login ghcr.io/github-technology-partners
./ghe-storage-test.sh -p s3 -v 3.5 \
  -c "BucketName=github-actions-storage-test;AccessKeyId=$AWS_ACCESS_KEY_ID;SecretAccessKey=$AWS_SECRET_KEY;ServiceUrl=https://s3.us-east-1.amazonaws.com;PathPrefix=actions-l2;ForcePathStyle=true"
```
NOTE: If you are using a self-signed certificate on your S3 Object store service in the test environment where you're running this command you may run into issues.

By default container from the latest released GHES version is used. Other version may be specified using `-v` switch, e.g. `-v 3.2` 

To login to docker, you'll need a [Personal Access Token](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry) with `read:package` scope.
