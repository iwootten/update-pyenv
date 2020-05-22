#!/bin/bash

pyenv_file=$GITHUB_WORKSPACE/${GITHUB_WORKSPACE##*/}/.python-version
current_version=$(cat $pyenv_file)

get_major_python_version(){
    IFS='.'
    read -ra ADDR <<< "$current_version"
    IFS=' '
    echo ${ADDR[0]}.${ADDR[1]}.
}

current_major_version=$(get_major_python_version)

available_versions=$( curl -s 'https://raw.githubusercontent.com/actions/python-versions/master/versions-manifest.json' | jq '[.[] | select( .version | startswith("'${current_major_version}'")) | .version] | .[0]' )

latest_version=$(sed -e 's/^"//' -e 's/"$//' <<< $available_versions)

echo "Current version: ${current_version}"
echo "Latest version: ${latest_version}"

if [ $current_version != $latest_version ]; then
    echo "Versions differ, updating .python-version"
    echo $latest_version > $pyenv_file
fi
