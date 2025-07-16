# Operator Versions

Shell script to get all versions of OpenShift operators for a particular OpenShift cluster.

Packaged as a docker image.

## Local development

Prerequisites

- [`shellcheck`](https://github.com/koalaman/shellcheck) for linting
- OpenShift cluster
- Docker

### Linting

Do shell script linting with `shellcheck`:

```sh
shellcheck get-versions.sh
```

## License

Copyright 2025.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
