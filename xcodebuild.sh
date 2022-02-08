mkdir -p xcode

buildIos() {
  echo building for iOS
  xcodebuild -sdk iphoneos -arch arm64 -project jdk-ios.xcodeproj -scheme jdk-arm64-debug   > xcode/jdk-arm64-d.log 2>&1
  xcodebuild -sdk iphoneos -arch arm64 -project jdk-ios.xcodeproj -scheme jdk-arm64-release > xcode/jdk-arm64-r.log 2>&1

  lipo -info xcode/jdk-arm64-ios-d.a
  lipo -info xcode/jdk-arm64-ios-r.a
}

buildIosSimulator() {
  echo building for iOS Simulator
  xcodebuild -sdk iphonesimulator -arch x86_64 -project jdk-ios.xcodeproj -scheme jdk-x86-64-debug   > xcode/x86-64-ios-simulator-d.log 2>&1
  xcodebuild -sdk iphonesimulator -arch x86_64 -project jdk-ios.xcodeproj -scheme jdk-x86-64-release > xcode/x86-64-ios-simulator-r.log 2>&1

  lipo -info xcode/jdk-x86-64-ios-simulator-d.a
  lipo -info xcode/jdk-x86-64-ios-simulator-r.a
}

# Mac Catalyst
buildMacCatalyst() {
  echo building for catalyst
  xcodebuild -sdk macosx -arch x86_64 -project jdk-ios.xcodeproj -scheme jdk-x86-64-debug   > xcode/x86-64-mac-catalyst-d.log 2>&1
  xcodebuild -sdk macosx -arch x86_64 -project jdk-ios.xcodeproj -scheme jdk-x86-64-release > xcode/x86-64-mac-catalyst-r.log 2>&1
  xcodebuild -sdk macosx -arch arm64 -project jdk-ios.xcodeproj -scheme jdk-arm64-debug     > xcode/arm64-mac-catalyst-r.log 2>&1
  xcodebuild -sdk macosx -arch arm64 -project jdk-ios.xcodeproj -scheme jdk-arm64-release   > xcode/arm64-mac-catalyst-r.log 2>&1
  lipo -info xcode/jdk-x86-64-mac-catalyst-d.a
  lipo -info xcode/jdk-x86-64-mac-catalyst-r.a
  lipo -info xcode/jdk-arm64-mac-catalyst-d.a
  lipo -info xcode/jdk-arm64-mac-catalyst-r.a
}

buildIos
buildIosSimulator
#buildMacCatalyst
