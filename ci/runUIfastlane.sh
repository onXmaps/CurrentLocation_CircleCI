#!/bin/bash

#bundle exec fastlane $1
#test_exit_code=$?
#cd /Users/distiller/Library/Developer/Xcode/DerivedData/
#find * -name '*.xcresult' -exec zip -r {}.zip {} \; -exec cp -r {}.zip ~/project/fastlane/logs \; || true
#cd -
#exit $test_exit_code

xcodebuild test -scheme "CurrentLocation"  -destination 'platform=iOS Simulator,OS=15.0,name=iPhone 12 Pro Max' -testPlan UITests
