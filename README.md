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
docker login ghcr.io/github-technology-partners
./ghe-storage-test.sh -p s3 -c "BucketName=github-actions-storage-test;AccessKeyId=$AWS_ACCESS_KEY_ID;SecretAccessKey=$AWS_SECRET_KEY;ServiceUrl=https://s3.us-east-1.amazonaws.com;PathPrefix=actions-l2"
```

By default container from the latest released GHES version is used. Other version may be specified using `-v` switch, e.g. `-v 3.2` 

To login to docker, you'll need a Personal Access Token with `read:package` scope and those are detailed here: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry
