# OpenShift Operator Versions

Shell script to get all versions of OpenShift operators for an OpenShift cluster. The background of the need for this script was to [get the latest versions of operators in the "redhat-operators" catalog](https://github.com/renovatebot/renovate/discussions/32180), so [Mend Renovate](https://www.mend.io/renovate/) could automatically create updates when new versions are available for an OpenShift cluster. Renovate does not have support for operator subscriptions or source catalogues. With inspiration from [a blog to get the operator version for every operator available](https://medium.com/red-hat-openshift-operator-versions/recently-i-was-asked-if-there-was-a-way-to-get-the-operator-version-for-every-operator-available-ceb27ed29923), this script was developed.

The shell script is packaged as a container image.

The result of running the script is JSON files, one for each operator.

The resulting JSON files need to be stored in a public folder, so Renovate can use them as a [custom data-source](https://docs.renovatebot.com/modules/datasource/custom/) to create version updates for operators.

Example output for the `loki-operator` for an OpenShift cluster on version 4.18.11:

`loki-operator.json`

```json
{
  "releases": [
    {
      "version": "v6.1.7"
    },
    {
      "version": "v6.2.3"
    }
  ]
}
```

## Local development

Prerequisites:

- [`shellcheck`](https://github.com/koalaman/shellcheck) for linting
- OpenShift cluster for running the script and getting the operator versions
- Container tool for building the container image such as Docker or Podman

### Linting

Do shell script linting with `shellcheck`:

```sh
shellcheck get-versions.sh
```

## License

Copyright 2025.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
