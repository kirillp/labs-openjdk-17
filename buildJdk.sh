# Find latest jvmci-* tag in current branch.
JVMCI_VERSION=$(git log --decorate | grep -E 'tag: jvmci-\d+\.\d+-b\d+' | sed 's/.*(\(tag: .*\))/\1/g' | tr ',' '\n' | grep 'tag:' | sed 's/.*tag: \(jvmci-[^,)]*\).*/\1/g' | sort -nr | head -1)

# Configure and build
sh configure --with-conf-name=labsjdk \
    --with-version-opt=$JVMCI_VERSION \
    --with-version-pre= \
    '--with-vendor-name=GraalVM Community' \
    --with-vendor-url=https://www.graalvm.org/ \
    --with-vendor-bug-url=https://github.com/oracle/graal/issues \
    --with-vendor-vm-bug-url=https://github.com/oracle/graal/issues
make CONF_NAME=labsjdk graal-builder-image

sh xcodebuild.sh
