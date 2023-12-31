# Deploying the Cloud Run Chat Bot App

First, run the following to build the chatbot. Note that it can take a while to build on newer MacOS machines because it needs to build an `amd64` image (not ARM) and the cross-platform build tools slow things down an order of magnitude. It took 7 minutes to build on my M1 Macbook.
```sh
make build_chatbot
```

If this successfully builds, the [.env](../../.env) file will be updated with the following environment variable:
```sh
CHATBOT_SERVICE_IMAGE=gcr.io/<YOUR_PROJECT_ID>/chatbot:latest
```

After you confirm everything worked, run the following to deploy the chatbot:

```sh
make terraform_apply
```

The output will include the URL for the deployed chatbot. You can also find this in the [Cloud Run console](https://console.cloud.google.com/run).

```
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

chatbot_uri = [
  "https://chatbot-...-uc.a.run.app",
]
```
