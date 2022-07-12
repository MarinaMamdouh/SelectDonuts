//
//  ViewController.swift
//  SelectDonuts
//
//  Created by Marina on 12/07/2022.
//

import UIKit

class TouchCaptureGesture: UIGestureRecognizer {
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

class MainViewController: UIViewController {
    var rectangles:[UIView] = []
    var touchGesture:TouchCaptureGesture!
    var selectedRectangles:[UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rectangles = self.view.subviews
        touchGesture = TouchCaptureGesture(target: self, action: #selector(handleTap(gesture:)))
        self.view.addGestureRecognizer(touchGesture)
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer){
        if gesture.state == .ended {
            for selectedRectangle in selectedRectangles{
                selectedRectangle.backgroundColor = .white
            }
            selectedRectangles = []
            return
        }
        let gestureLocation = gesture.location(in: self.view)
        for rectangle in rectangles{
            if isTap(location: gestureLocation, inside: rectangle){
                selectedRectangles.append(rectangle)
                rectangle.backgroundColor = .blue
                return
            }
        }
        
        
    }
    
    func isTap(location: CGPoint , inside view:UIView)->Bool{
        let startPoint = view.frame.origin
        let endPoint = CGPoint(x: view.frame.origin.x + view.frame.width, y: view.frame.origin.y + view.frame.height)
        
        if location.x >= startPoint.x && location.x <= endPoint.x{
            if location.y >= startPoint.y && location.y <= endPoint.y{
                return true
            }
        }
        return false
    }


}

