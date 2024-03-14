//
//  CustomUIApplication.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//

import UIKit

class CustomApplication: UIApplication {
    private var timerToDetectInactivity: Timer?
    private var showScreenSaverInSeconds: TimeInterval {
        return 4 * 60
    }
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouch.Phase.began {
                self.resetTimer()
            }
        }
    }
    
    // reset the timer because there was user event
    private func resetTimer() {
        if let timerToDetectInactivity = timerToDetectInactivity {
            timerToDetectInactivity.invalidate()
        }

        timerToDetectInactivity = Timer.scheduledTimer(timeInterval: showScreenSaverInSeconds,
                                         target: self,
                                         selector: #selector(CustomApplication.showScreenSaver),
                                         userInfo: nil,
                                         repeats: false
        )
    }

    @objc private func showScreenSaver() {
       //Present screen
    }
}
