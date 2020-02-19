#!/bin/bash

IMAGE="mantidproject/mantid"

function build_image {
  DOCKERFILE=$1
  TAG=$2
  PACKAGE=$3
  PATH_ADDITIONS=$4
  EXPECTED_VERSION=$5

  docker build \
    --file=${DOCKERFILE} \
    --tag=${IMAGE}:${TAG} \
    --build-arg PACKAGE=${PACKAGE} \
    --build-arg PATH_ADDITIONS=${PATH_ADDITIONS} \
    .
  build_result=$?

  if [ $build_result -ne 0 ]; then
    echo "Build of image for tag \"$TAG\" failed"
    return $build_result
  fi

  # Try to do a thing in Python for the image that has just been built
  version_test=$(docker run --rm mantidproject/mantid:$TAG mantidpython /mantid_version_check.py)

  echo "$version_test"

  if [ -n "$EXPECTED_VERSION" ]; then
    if [ "$EXPECTED_VERSION" == "$version_test" ]; then
      echo "Image with tag \"$TAG\" is correct"
    else
      echo "Image with tag \"$TAG\" failed to build correctly"
      return 1
    fi
  else
    echo "Ignoring expected version test, just looking for something"
    if [ -n "$version_test" ]; then
      echo "Have \"$version_test\" for version string, close enough"
    else
      echo "No version string, something is probably broken"
      return 1
    fi
  fi
}
