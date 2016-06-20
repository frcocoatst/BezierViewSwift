//
//  BezierView.swift
//  BezierView
//
//  Created by Friedrich HAEUPL on 09.05.16.
//  Copyright © 2016 Friedrich HAEUPL. All rights reserved.
//


import Cocoa

class BezierView: NSView{
    
    var controlPoint_1 = NSPoint()
    var controlPoint_2 = NSPoint()
    var startPoint = NSPoint()
    var endPoint  = NSPoint()
    
    var startpoint_selected  = false
    var endpoint_selected  = false
    var controlpoint1_selected  = false
    var controlpoint2_selected  = false
    
    
    // initialize various points
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.controlPoint_1 = NSPoint(x: 400, y: 400)
        self.controlPoint_2 = NSPoint(x: 200, y: 80)
        self.startPoint = NSPoint(x: 100, y: 100)
        self.endPoint = NSPoint(x: 500, y: 100)
    }
    
    // drawRect
    
    override func drawRect(dirtyRect: NSRect)
    {
        // Examples are taken from:
        
        // let CONNRADIUS = 2.0
        // let SELECTRADIUS = 20
        
        NSColor.whiteColor().setFill()
        NSRectFill(self.bounds)
        //
        super.drawRect(dirtyRect)
        //
        self.drawIt()
    }
    
    func drawIt() {
        // show control points
        var dotRect = NSRect()
        
        let mycurve = NSBezierPath()
        let cpath = NSBezierPath()
        let apath = NSBezierPath()

/*      apath.removeAllPoints()
        cpath.removeAllPoints()
        mycurve.removeAllPoints()
 */
        dotRect.origin.x = controlPoint_1.x - 2.0
        dotRect.origin.y = controlPoint_1.y - 2.0
        dotRect.size.width = 2 * 2.0
        dotRect.size.height = 2 * 2.0
        
        NSColor.blueColor().set()
        cpath.appendBezierPathWithOvalInRect(dotRect)
        cpath.lineWidth = 1
        cpath.stroke()
        
        dotRect.origin.x = controlPoint_2.x - 2.0
        dotRect.origin.y = controlPoint_2.y - 2.0
        dotRect.size.width = 2 * 2.0
        dotRect.size.height = 2 * 2.0
        
        NSColor.blueColor().set()
        cpath.appendBezierPathWithOvalInRect(dotRect)
        cpath.lineWidth = 1
        cpath.stroke()
        
        dotRect.origin.x = startPoint.x - 2.0
        dotRect.origin.y = startPoint.y - 2.0
        dotRect.size.width = 2 * 2.0
        dotRect.size.height = 2 * 2.0
        
        NSColor.blueColor().set()
        cpath.appendBezierPathWithOvalInRect(dotRect)
        cpath.lineWidth = 1
        cpath.stroke()
        
        dotRect.origin.x = endPoint.x - 2.0
        dotRect.origin.y = endPoint.y - 2.0
        dotRect.size.width = 2 * 2.0
        dotRect.size.height = 2 * 2.0
        
        NSColor.blueColor().set()
        cpath.appendBezierPathWithOvalInRect(dotRect)
        cpath.lineWidth = 1
        cpath.stroke()
        
        // show tangent
        NSColor.redColor().set()
        apath.moveToPoint(startPoint)
        apath.lineToPoint(controlPoint_1)
        apath.stroke()
        
        apath.moveToPoint(endPoint)
        apath.lineToPoint(controlPoint_2)
        apath.stroke()
        
        
        // mycurve.moveToPoint(startPoint)
        // mycurve.curveToPoint(endPoint, controlPoint1: controlPoint_1, controlPoint2: controlPoint_2)
        // replaced by:
        
        // show resulting curve with Arrow
        /*
        mycurve.appendBezierPath(NSBezierPath.curveWithArrow(startPoint, endPoint: endPoint,
            controlPoint1: controlPoint_1, controlPoint2: controlPoint_2,
            tailWidth: 4, headWidth: 10, headLength: 20))
         */
        
        mycurve.appendBezierPath(NSBezierPath.curveFromPointtoPointWithcontrolPoints(startPoint, endPoint: endPoint,
            controlPoint1: controlPoint_1, controlPoint2: controlPoint_2,
            tailWidth: 1, headWidth: 10, headLength: 20))
        
        
        // Draw the outline
        // NSColor.blueColor().set()
        // mycurve.lineWidth = 4
        mycurve.stroke()
        
    }
    
    func testPointInRect(point: NSPoint)->Bool {
        var aRect = NSRect()
        
        // test if startpoint is selected
        aRect.origin.x = startPoint.x - 20.0;
        aRect.origin.y = startPoint.y - 20.0;
        aRect.size.width  = 2 * 20.0;
        aRect.size.height = 2 * 20.0;
        if (NSPointInRect(point, aRect) == true)
        {
            startpoint_selected = true;
            NSLog("startpoint_selected");
        }
        else
        {
            // test if endpoint is selected
            aRect.origin.x = endPoint.x - 20.0;
            aRect.origin.y = endPoint.y - 20.0;
            aRect.size.width  = 2*20.0;
            aRect.size.height = 2*20.0;
            if (NSPointInRect(point, aRect) == true)
            {
                endpoint_selected = true;
                NSLog("endpoint_selected");
            }
            else
            {
                // test if controlpoint1 is selected
                aRect.origin.x = controlPoint_1.x - 20.0;
                aRect.origin.y = controlPoint_1.y - 20.0;
                aRect.size.width  = 2*20.0;
                aRect.size.height = 2*20.0;
                if (NSPointInRect(point, aRect) == true)
                {
                    controlpoint1_selected = true;
                    NSLog("controlpoint1_selected");
                }
                else
                {
                    // test if controlpoint1 is selected
                    aRect.origin.x = controlPoint_2.x - 20.0;
                    aRect.origin.y = controlPoint_2.y - 20.0;
                    aRect.size.width  = 2*20.0;
                    aRect.size.height = 2*20.0;
                    if (NSPointInRect(point, aRect) == true)
                    {
                        controlpoint2_selected = true;
                        NSLog("controlpoint1_selected");
                    }
                }
            }
        }
        return false
    }
    
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        //
        NSLog("mouseDown");
        
        var mousePointInView = theEvent.locationInWindow
        mousePointInView.x -= frame.origin.x
        mousePointInView.y -= frame.origin.y
        //newLinear.moveToPoint(lastPt)
        
        if (self.testPointInRect(mousePointInView)==true)
        {
            NSLog("hit");
        }
        else
        {
            NSLog("no hit");
        }
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        super.mouseDragged(theEvent)
        
        var mousePointInView = theEvent.locationInWindow
        mousePointInView.x -= frame.origin.x
        mousePointInView.y -= frame.origin.y
        //
        // set new position of the selected point
        
        if (startpoint_selected == true)
        {
            startPoint = mousePointInView;
        }
        else
            if (endpoint_selected == true)
            {
                endPoint = mousePointInView;
            }
            else
                if (controlpoint1_selected == true)
                {
                    controlPoint_1 = mousePointInView;
                }
                else
                    if (controlpoint2_selected == true)
                    {
                        controlPoint_2 = mousePointInView;
        }
        
        NSLog("mouseDragged");
        
        needsDisplay = true
        //setNeedsDisplayInRect(bounds)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        
        NSLog("mouseUp");
        
        startpoint_selected     = false;
        endpoint_selected       = false;
        controlpoint1_selected  = false;
        controlpoint2_selected  = false;
        
        //needsDisplay = true
    }
    /*
     override var acceptsFirstResponder: Bool {
     return true
     }
     
     override func keyDown(theEvent: NSEvent) {
     NSLog("key down is \(theEvent.description)") //system console should be displaying the keypress
     }
     */   
}
