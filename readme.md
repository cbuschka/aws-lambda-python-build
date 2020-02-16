# Docker based python aws lambda build

### Ingredients
* multi stage docker build
  - caches interim results
* precompiling to .pyc files
  - improves aws lambda startup time
* packaging with dependencies as zip
  - self contained package
  - also contains uptodate boto3

### Build
```
make
```

### Todo
* integration test with package
* use awslinux

### License
Written by [Cornelius Buschka](https://github.com/cbuschka).

[MIT license](./license.txt)
