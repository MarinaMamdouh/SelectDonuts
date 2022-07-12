//
//  ViewController.swift
//  SelectDonuts
//
//  Created by Marina on 12/07/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var rectangles:[UIView] = []
    var touchGesture:TouchGesture!
    var selectedRectangles:[UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rectangles = self.view.subviews
        touchGesture = TouchGesture(target: self, action: #selector(handleTap(gesture:)))
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
    
    private func isTap(location: CGPoint , inside view:UIView)->Bool{
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

