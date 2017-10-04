# AudioKit Amplitude Tracker

This is a Swift project that demonstrates the following:

1. Set up the AudioKit engine as a singleton class called, `Conductor`, which contains all of the audio routing, control, and effects.
2. How to track the amplitude of the input from a microphone.

## Installation

This app was created using Swift 4 and Xcode 9. It utilizes the [AudioKit](https://github.com/AudioKit/AudioKit) open-source library for its audio processing. In order to import the AudioKit framework via [CocoaPods](https://cocoapods.org/):

1. Run `pod update` in the command line.
2. Launch the `AmplitudeTracker.xcworkspace` – _not_ the `AmplitudeTracker.xcodeproj`
