# Update python version

A simple github action to update the version of python denoted in a .python-version file to the latest avalable patch release in [actions/python-versions](https://raw.githubusercontent.com/actions/python-versions/master/versions-manifest.json). 

Update python version will:

1. Check a .python-version is available in the root of the repo
2. Parse the current minor python release from the .python-version and find the latest available patch version in github from [actions/python-versions](https://raw.githubusercontent.com/actions/python-versions/master/versions-manifest.json)
3. Update the .python-version file if the current version number differs from the latest available

## Usage

```yml
    - name: Update python version
      uses: iwootten/update-python-version@v1
```

You can use this in combination with [actions/checkout](https://github.com/peter-evans/create-pull-request) and [peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request)  to create pull requests when new versions of python become available in github actions.

```yml
    - uses: actions/checkout@v2
      with:
        ssh-key: ${{ secrets.SSH_PRIVATE_KEY }}
    - uses: iwootten/update-python-version@v1
      id: update-python
    - name: Create Pull Request
      if: ${{ steps.update-python.outputs.updated == 'true' }}
      uses: peter-evans/create-pull-request@v2
      with: 
        commit-message: "Update .python-version to ${{ steps.update-python.outputs.latest-version }}"
        title: Update .python-version to ${{ steps.update-python.outputs.latest-version }}
```

## Action outputs

| Name | Description |
|------|-------------|
| original_version | The version originally specified in the .python-version file |
| latest_version | The latest patch version |
| updated | Boolean which indicates if the .python-version was updated