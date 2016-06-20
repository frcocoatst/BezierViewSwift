//
//  BezierView.swift
//  BezierView
//
//  Created by FH on 09.05.16.
//  Copyright © 2016 FH. All rights reserved.
//


import Cocoa

class BezierView: NSView{
    
    let PADSIZE:CGFloat = 4.0
    let SELECTRADIUS:CGFloat = 20
    
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
        dotRect.origin.x = controlPoint_1.x - PADSIZE
        dotRect.origin.y = controlPoint_1.y - PADSIZE
        dotRect.size.width = 2 * PADSIZE
        dotRect.size.height = 2 * PADSIZE
        
        NSColor.blueColor().set()
        cpath.appendBezierPathWithOvalInRect(dotRect)
        cpath.lineWidth = 1
        cpath.stroke()
        
        dotRect.origin.x = controlPoint_2.x - PADSIZE
        dotRect.origin.y = controlPoint_2.y - PADSIZE
        dotRect.size.width = 2 * PADSIZE
        dotRect.size.height = 2 * PADSIZE
        
        NSColor.blueColor().set()
        cpath.appendBezierPathWithOvalInRect(dotRect)
        cpath.lineWidth = 1
        cpath.stroke()
        
        dotRect.origin.x = startPoint.x - PADSIZE
        dotRect.origin.y = startPoint.y - PADSIZE
        dotRect.size.width = 2 * PADSIZE
        dotRect.size.height = 2 * PADSIZE
        
        NSColor.blueColor().set()
        cpath.appendBezierPathWithOvalInRect(dotRect)
        cpath.lineWidth = 1
        cpath.stroke()
        
        dotRect.origin.x = endPoint.x - PADSIZE
        dotRect.origin.y = endPoint.y - PADSIZE
        dotRect.size.width = 2 * PADSIZE
        dotRect.size.height = 2 * PADSIZE
        
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
        aRect.origin.x = startPoint.x - SELECTRADIUS;
        aRect.origin.y = startPoint.y - SELECTRADIUS;
        aRect.size.width  = 2 * SELECTRADIUS;
        aRect.size.height = 2 * SELECTRADIUS;
        if (NSPointInRect(point, aRect) == true)
        {
            startpoint_selected = true;
            NSLog("startpoint_selected");
        }
        else
        {
            // test if endpoint is selected
            aRect.origin.x = endPoint.x - SELECTRADIUS;
            aRect.origin.y = endPoint.y - SELECTRADIUS;
            aRect.size.width  = 2*SELECTRADIUS;
            aRect.size.height = 2*SELECTRADIUS;
            if (NSPointInRect(point, aRect) == true)
            {
                endpoint_selected = true;
                NSLog("endpoint_selected");
            }
            else
            {
                // test if controlpoint1 is selected
                aRect.origin.x = controlPoint_1.x - SELECTRADIUS;
                aRect.origin.y = controlPoint_1.y - SELECTRADIUS;
                aRect.size.width  = 2*SELECTRADIUS;
                aRect.size.height = 2*SELECTRADIUS;
                if (NSPointInRect(point, aRect) == true)
                {
                    controlpoint1_selected = true;
                    NSLog("controlpoint1_selected");
                }
                else
                {
                    // test if controlpoint1 is selected
                    aRect.origin.x = controlPoint_2.x - SELECTRADIUS;
                    aRect.origin.y = controlPoint_2.y - SELECTRADIUS;
                    aRect.size.width  = 2*SELECTRADIUS;
                    aRect.size.height = 2*SELECTRADIUS;
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
}
