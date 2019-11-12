#!/bin/bash -x

ENVIRONMENT="$1"
CURRENT_BRANCH="$2"
#echo "CURRENT_BRANCH=${CURRENT_BRANCH}" >> ./environment/${ENVIRONMENT}.env 
export $(grep -v '^#' ./environment/${ENVIRONMENT}.env | xargs)

TEMPLATE_PATH='./templates'
COMPONENTS_PATH='./components'

echo "Dumping environment to JSON";
jq -n env > environment.json;

for source_file in `find "$TEMPLATE_PATH" -name '*.j2'`;
do
    destination_with_extension="${source_file//$TEMPLATE_PATH/$COMPONENTS_PATH}";
    destination=${destination_with_extension%.*};

    echo "Generating $destination"
    mkdir -p "$(dirname "$destination")"
    jinja2 --format=json $source_file ./environment.json > $destination;
done

