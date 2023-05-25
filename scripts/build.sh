#!/bin/bash

export RB_VERSION=${TRAVELING_RUBY_RB_VERSION:-3.2.2}
export ARCHITECTURES=${TRAVELING_RUBY_ARCHITECTURE:-arm64}
export PKG_DATE=${TRAVELING_RUBY_PKG_DATE:-20230428}
export PLATFORM=${TRAVELING_RUBY_PLATFORM:-linux}
rm VERSION.txt
echo $TRAVELING_RUBY_PKG_DATE > VERSION.txt
case "$PLATFORM" in
    "Darwin")
        export PLATFORM="osx"
        ;;
    "Linux")
        export PLATFORM="linux"
        ;;
    "Windows")
        export PLATFORM="windows"
        ;;
esac
mkdir -p build
cd $PLATFORM



if [[ ("$PLATFORM" == "osx") && "$USE_ROSETTA" == "true" ]]; then
    softwareupdate --install-rosetta --agree-to-license
    rbenv local system
    sudo gem install bundler:2.4.10
    rbenv global ${RB_VERSION}
    rake stash_conflicting_paths
    arch -x86_64 rake --trace
    rake unstash_conflicting_paths
elif [[ "$PLATFORM" == "osx" ]]; then
    rbenv local system
    sudo gem install bundler:2.4.10
    rbenv global ${RB_VERSION}
    rake stash_conflicting_paths
    rake --trace
    rake unstash_conflicting_paths
elif [[ "$PLATFORM" == "linux" ]]; then
    rake image
    rake
elif [[ "$PLATFORM" == "windows" ]]; then
    sh -c "mkdir -p cache output/${RB_VERSION}"
    sh -c "./build-ruby -a x86 -r ${RB_VERSION} cache output/${RB_VERSION}"
    sh -c "./package -r traveling-ruby-${PKG_DATE}-${RB_VERSION}-x86-windows.tar.gz output/${RB_VERSION}"
    sh -c "ls"
    sh -c "rm -rf cache output/${RB_VERSION}"
    sh -c "mkdir -p cache output/${RB_VERSION}"
    sh -c "./build-ruby -a x86_64 -r ${RB_VERSION} cache output/${RB_VERSION}"
    sh -c "./package -r traveling-ruby-${PKG_DATE}-${RB_VERSION}-x86_64-windows.tar.gz output/${RB_VERSION}"
fi

ls
if [[ "$PLATFORM" == "windows" ]]; then
    tar cvzf traveling-ruby-gems-${PKG_DATE}-${RB_VERSION}-x86-${PLATFORM}.tar.gz traveling-ruby-gems-${PKG_DATE}-${RB_VERSION}-x86-${PLATFORM}/
    # tar cvzf traveling-ruby-gems-${PKG_DATE}-${RB_VERSION}-x86_64-${PLATFORM}.tar.gz traveling-ruby-gems-${PKG_DATE}-${RB_VERSION}-x86_64-${PLATFORM}/
    cp -R traveling-ruby-${PKG_DATE}-${RB_VERSION}-x86-${PLATFORM}.tar.gz ../build
    cp -R traveling-ruby-${PKG_DATE}-${RB_VERSION}-x86_64-${PLATFORM}.tar.gz ../build
else
    tar cvzf traveling-ruby-gems-${PKG_DATE}-${RB_VERSION}-${ARCHITECTURES}-${PLATFORM}.tar.gz traveling-ruby-gems-${PKG_DATE}-${RB_VERSION}-${ARCHITECTURES}-${PLATFORM}/
    cp -R traveling-ruby-gems-${PKG_DATE}-${RB_VERSION}-${ARCHITECTURES}-${PLATFORM}.tar.gz ../build
    cp -R traveling-ruby-${PKG_DATE}-${RB_VERSION}-${ARCHITECTURES}-${PLATFORM}.tar.gz ../build
fi
ls
ls ../build