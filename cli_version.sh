#!/bin/bash

export REPLICATE_TOKEN=
export trainer_model=ostris/flux-dev-lora-trainer
export steps=100
export destination=
export trainer_version=


 FILE_UPLOAD_RESPONSE=$(
            curl -X POST "https://api.replicate.com/v1/files" \
              -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
              -H "Content-Type: multipart/form-data" \
              -F "content=@data.zip;type=application/zip;filename=data.zip"
)

export="INSTANCE_DATA_URL=$(jq -r '.urls.get' <<< $FILE_UPLOAD_RESPONSE)"


TRAINING_RESPONSE=$(
curl -X POST \
          -H "Authorization: Bearer $REPLICATE_TOKEN" \
          -H "Content-Type: application/json" \
          -d '{
                  "destination": $destination,
                  "input": {
                      "trigger_word": "''$trigger_word"'',
                      "input_images": "''$INSTANCE_DATA_URL"'',
                      "steps": "''$steps"''
                  }
              }' \
          "https://api.replicate.com/v1/models/ostris/flux-dev-lora-trainer/versions/7f53f82066bcdfb1c549245a624019c26ca6e3c8034235cd4826425b61e77bec/trainings"
)


