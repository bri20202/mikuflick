# IPA Inspection Notes (miku.ipa)

This summary is based on locally extracting the IPA and inspecting the app bundle `Info.plist`.

## Bundle metadata

- **App name**: `MikuFlick2`
- **Bundle ID**: `com.sega.MikuFlick02`
- **Version**: `1.1.5` (short version and build)
- **Minimum iOS**: `5.0`
- **Supported devices**: iPhone + iPad (`UIDeviceFamily` 1, 2)
- **Required capabilities**: `armv7`, `opengles-2`, `gamekit`
- **Orientation**: Portrait + upside-down portrait
- **SDK/Xcode**: Built with iOS 8.0 SDK, Xcode 6 (`DTSDKName` `iphoneos8.0`, `DTXcode` `0600`)

## Notes for modern iOS compatibility

- The **minimum OS** and **SDK build** indicate a legacy build chain (iOS 5 target, iOS 8 SDK).
- The **required capabilities** include `armv7` and `opengles-2`, so the binary predates modern 64-bit-only requirements.
- Without the **original source**, we can’t recompile or upgrade this binary; we should treat the IPA as a reference artifact.

## Next steps (if we want to modernize)

1. Identify or rebuild the **source project**.
2. Recreate assets/logic and retarget to a modern iOS deployment target (iOS 16+).
3. Replace OpenGL ES usage (if present) with Metal/SwiftUI-friendly rendering.

