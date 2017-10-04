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
        
        /// Set whether to DefaultToSpeaker when audio input is enabled
        AKSettings.defaultToSpeaker = false
        
        // Capture mic input
        mic = AKMicrophone()
        
        // Pass mic output into the tracker
        tracker = AKAmplitudeTracker(mic)
        
        // Pass the tracker output into the delay effect
        delay = AKDelay(tracker)
        delay.time = 2.0
        delay.feedback = 0.1
        delay.dryWetMix = 0.5
        
        // Pass the delay output into the reverb effect
        reverb = AKCostelloReverb(delay)
        reverb.presetShortTailCostelloReverb()
        
        // Mix the amount of reverb to the delay output
        reverbAmountMixer = AKDryWetMixer(delay, reverb, balance: 0.8)
        
        // Assign the reverbAmountMixer output to be the final audio output
        AudioKit.output = reverbAmountMixer
        
        // Start the AudioKit engine
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
