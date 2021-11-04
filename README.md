## Enterprise Storage Check

This repository to allow partners to perform a storage check against GitHub Enterprise Server, without having to install a complete GitHub Enterprise Server instance.

Currently covered:
- Actions Artifacts and Logs

Currently not covered:
- Direct download links from the storage, used for Artifact Cache
- Packages

## Usage

You can use this repository as a codespace, or locally using the following commands.

**To test Actions Artifacts and Logs:**

```
docker login containers.pkg.github.com/github
docker pull containers.pkg.github.com/github/actions/actions-console:main
./ghe-storage-test.sh -c "Test-StorageConnection -OverrideBlobProvider s3 -OverrideConnectionString 'BucketName=github-actions-storage-test;AccessKeyId=$AWS_ACCESS_KEY_ID;SecretAccessKey=$AWS_SECRET_KEY;ServiceUrl=https://s3.us-east-1.amazonaws.com;PathPrefix=actions-l2'"
```

To login to docker, you'll need a Personal Access Token and those are detailed here: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry
