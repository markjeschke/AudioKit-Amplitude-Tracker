//
//  ViewController.swift
//  AmplitudeTracker
//
//  Created by Mark Jeschke on 10/3/17.
//  Copyright © 2017 Mark Jeschke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var conductor = Conductor.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [unowned self] (timer) in
            print(self.conductor.tracker.amplitude)
        }
            
    }

}

