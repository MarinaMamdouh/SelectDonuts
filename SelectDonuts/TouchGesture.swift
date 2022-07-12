//
//  TouchGesture.swift
//  SelectDonuts
//
//  Created by Marina on 12/07/2022.
//

import UIKit

// Continous Gesture to capure stroke of touches
class TouchGesture: UIGestureRecognizer {
   var trackedTouch: UITouch? = nil
   var points = [CGPoint]()
 
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        self.points = [CGPoint]()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
       if touches.count != 1 {
          self.state = .failed
       }
     
       // Capture the first touch and store some information about it.
       if self.trackedTouch == nil {
          if let firstTouch = touches.first {
             self.trackedTouch = firstTouch
             self.addLocation(for: firstTouch)
             state = .began
          }
       } else {
          // Ignore all but the first touch.
          for touch in touches {
             if touch != self.trackedTouch {
                self.ignore(touch, for: event)
             }
          }
       }
    }
     
    func addLocation(for touch: UITouch) {
       let newLocation = touch.location(in: self.view)
       self.points.append(newLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.addLocation(for: touches.first!)
       state = .changed
    }
     
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.addLocation(for: touches.first!)
       state = .ended
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.points.removeAll()
       state = .cancelled
    }
     
    override func reset() {
       self.points.removeAll()
       self.trackedTouch = nil
    }
}

