rm -r xcode
mkdir -p xcode

buildIos() {
  echo building for iOS
  xcodebuild -sdk iphoneos -arch arm64 -project jdk-ios.xcodeproj -target jdk -configuration Debug  > xcode/jdk-iphoneos-d.log 2>&1
  xcodebuild -sdk iphoneos -arch arm64 -project jdk-ios.xcodeproj -target jdk -configuration Release > xcode/jdk-iphoneos-r.log 2>&1

  lipo -info xcode/jdk-ios-d.a
  lipo -info xcode/jdk-ios-r.a
}

buildIosSimulator() {
  echo building for iOS Simulator
  xcodebuild -sdk iphonesimulator -arch x86_64 -project jdk-ios.xcodeproj -target jdk -configuration Release  > xcode/jdk-iphonesimulator-x86_64-r.log 2>&1
  xcodebuild -sdk iphonesimulator -arch x86_64 -project jdk-ios.xcodeproj -target jdk -configuration Debug  > xcode/jdk-iphonesimulator-x86_64-d.log 2>&1
  
  mv xcode/jdk-ios-simulator-d.a xcode/jdk-ios-simulator-x86_64-d.a
  mv xcode/jdk-ios-simulator-r.a xcode/jdk-ios-simulator-x86_64-r.a

  xcodebuild -sdk iphonesimulator -arch arm64 -project jdk-ios.xcodeproj -target jdk -configuration Release > xcode/jdk-iphonesimulator-arm64-r.log 2>&1
  xcodebuild -sdk iphonesimulator -arch arm64 -project jdk-ios.xcodeproj -target jdk -configuration Debug  > xcode/jdk-iphonesimulator-arm64-d.log 2>&1

  mv xcode/jdk-ios-simulator-d.a xcode/jdk-ios-simulator-arm64-d.a
  mv xcode/jdk-ios-simulator-r.a xcode/jdk-ios-simulator-arm64-r.a

  lipo xcode/jdk-ios-simulator-arm64-d.a xcode/jdk-ios-simulator-x86_64-d.a -create -output xcode/jdk-ios-simulator-d.a
  lipo xcode/jdk-ios-simulator-arm64-r.a xcode/jdk-ios-simulator-x86_64-r.a -create -output xcode/jdk-ios-simulator-r.a

  rm xcode/jdk-ios-simulator-arm64-d.a xcode/jdk-ios-simulator-x86_64-d.a xcode/jdk-ios-simulator-arm64-r.a xcode/jdk-ios-simulator-x86_64-r.a

  lipo -info xcode/jdk-ios-simulator-d.a
  lipo -info xcode/jdk-ios-simulator-r.a
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
