# Miku Flick 02 (Modern iOS)

This repository is a starter recreation of **Miku Flick 02** focused on modern iOS compatibility. The goal is to rebuild the feel of the original rhythm-flick gameplay while taking advantage of SwiftUI, modern haptics, and scalable audio pipelines.

## Compatibility Goals

- **Minimum iOS target**: iOS 18 (modern SwiftUI navigation + haptics support).
- **Optimized for**: iOS 18+ with adaptive layouts.

## What Exists Today

- A SwiftUI starter interface with a song selection list, score/combo display, and note lane placeholders.
- A lightweight `GameViewModel` to drive state changes and a small note sequence.
- A settings sheet with gameplay + audio placeholders.

## Next Steps

1. Replace the placeholder note sequence with real song timing data.
2. Introduce gesture-driven flick detection (directional swipes + multi-touch).
3. Add audio playback using `AVAudioEngine` with beat-synced scheduling.
4. Build a results screen + song metadata detail panel.

## How To Use

- Open the project in Xcode.
- Set your bundle identifier and signing team.
- Run on a device to iterate on haptics and latency tuning.

## About Original Assets

Do not add the original Miku Flick 02 IPA or copyrighted assets to this repository. Use your own recreated assets or files you have explicit permission to redistribute.

## Adding Gameplay Videos

For demo footage, keep videos outside of the repo or store them via Git LFS/asset hosting, and reference them from documentation. Typical options:

1. **Host the video externally** (YouTube, Vimeo, GitHub Releases, or cloud storage) and link it in the README.
2. **Use Git LFS** for large binary files if you need the videos in-repo (requires LFS configured for the team).
3. **Export short GIFs** for lightweight previews, and store them in a `Media/` folder if size permits.

If you embed links, prefer a short “Demo” section with a thumbnail image and a URL.

### Git LFS Quick Start

If you decide to store large files in the repo, Git LFS is the recommended approach:

1. Install Git LFS: `git lfs install`
2. Track the file types you plan to store, for example:
   - `git lfs track "*.mp4"`
   - `git lfs track "*.mov"`
3. Commit the updated `.gitattributes` file created by Git LFS:
   - `git add .gitattributes`
4. Add your large files as usual:
   - `git add Media/demo.mp4`
5. Commit and push:
   - `git commit -m "Add gameplay demo video via LFS"`
   - `git push`

> Note: everyone cloning the repo should have Git LFS installed to fetch the binary content.

> The SwiftUI files live in the `MikuFlick02` directory.
