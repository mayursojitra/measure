# Release

## Measure SDK

To release the iOS SDK, follow the below steps.

1. Make sure you're on the latest commit on the main branch.
2. Build and run tests before releasing.
3. Run `./ios/Scripts/release.sh <major/minor/patch>`. This script is executed in below 2 steps:
   1. Update local versions
        - First the script will get the current SDK version from `FrameworkInfo.swift` and increment it.
        - It will then update the SDK versions in `MeasureSDK.podspec`, `FrameworkInfo.swift` and `README.md`.
        - Verify these before moving forward.
   2. Update CHANGELOG.md
        - We use git-cliff to generate change logs. This step might require you to add github-token with `public_repo` permission if the changes are too long.
4. Create a PR and merge.
5. Go to the releases tab and create a new release.
6. Run `pod trunk register adwin@measure.sh 'Adwin Ross' --description='macbook pro'` to authenticate to the cocoapod server.
7. Run `pod spec lint MeasureSDK.podspec` which will check if the current configuration of podspec is correct.
8. Run `pod trunk push MeasureSDK.podspec` to push the pod to cocoapods.