//
//  Conductor.swift
//  AmplitudeTracker
//
//  Created by Mark Jeschke on 10/3/17.
//  Copyright © 2017 Mark Jeschke. All rights reserved.
//

import AudioKit
import AudioKitUI

// Treat the conductor like a manager for the audio engine.
class Conductor {
    
    // Singleton of the Conductor class to avoid multiple instances of the audio engine
    static let sharedInstance = Conductor()
    
    // Create instance variables
    var mic: AKMicrophone!
    var tracker: AKAmplitudeTracker!
    
    // Add effects
    var delay: AKDelay!
    var reverb: AKCostelloReverb!
    
    // Balance between the delay and reverb mix.
    var reverbAmountMixer = AKDryWetMixer()
    
    init() {
        
        // Allow audio to play while the iOS device is muted.
        AKSettings.playbackWhileMuted = true
        
        // Capture mic input
        mic = AKMicrophone()
        
        // Pull mic output into the tracker node.
        tracker = AKAmplitudeTracker(mic)
        
        // Pull the tracker output into the delay effect node.
        delay = AKDelay(tracker)
        delay.time = 2.0
        delay.feedback = 0.1
        delay.dryWetMix = 0.5
        
        // Pull the delay output into the reverb effect node.
        reverb = AKCostelloReverb(delay)
        reverb.presetShortTailCostelloReverb()
        
        // Mix the amount of reverb to the delay output node.
        reverbAmountMixer = AKDryWetMixer(delay, reverb, balance: 0.8)
        
        // Assign the reverbAmountMixer output to be the final audio output
        AudioKit.output = reverbAmountMixer
        
        // Start the AudioKit engine
        // This is in its own method so that the audio engine will start and stop via the AppDelegate's current state.
        startAudioEngine()
        
    }
    
    internal func startAudioEngine() {
        AudioKit.start()
        print("Audio engine started")
    }
    
    internal func stopAudioEngine() {
        AudioKit.stop()
        print("Audio engine stopped")
    }
}
