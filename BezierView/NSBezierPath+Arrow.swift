//
//  NSBezierPath+Arrow.swift
//  BezierView
//
//  Created by Friedrich HAEUPL on 15.06.16.
//  Copyright © 2016 Friedrich HAEUPL. All rights reserved.
//
//  from: https://gist.github.com/mwermuth/07825df27ea28f5fc89a


//  also: https://gist.github.com/lukaskubanek/1f3585314903dfc66fc7
//  also:   https://github.com/XavierDK/XDKWalkthrough/blob/master/XDKWalkthroughExemple/XDKWalkthrough/UIBezierPath%2BXDKArrow.m


import Cocoa
import Foundation

extension NSBezierPath {
/*
    class func getAxisAlignedArrowPoints(inout points: Array<CGPoint>,
                                               forLength: CGFloat,
                                               tailWidth: CGFloat,
                                               headWidth: CGFloat,
                                               headLength: CGFloat ){
        
        let tailLength = forLength - headLength
        points.append(CGPointMake(0, tailWidth/2))
        points.append(CGPointMake(tailLength, tailWidth/2))
        points.append(CGPointMake(tailLength, headWidth/2))
        points.append(CGPointMake(forLength, 0))
        points.append(CGPointMake(tailLength, -headWidth/2))
        points.append(CGPointMake(tailLength, -tailWidth/2))
        points.append(CGPointMake(0, -tailWidth/2))
        
    }
    
    
    class func transformForStartPoint(startPoint: CGPoint,
                                      endPoint: CGPoint,
                                      length: CGFloat) -> CGAffineTransform{
        
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
        return CGAffineTransformMake(cosine, sine, -sine, cosine, startPoint.x, startPoint.y)
    }

    
    class func bezierPathWithArrowFromPoint(startPoint:CGPoint,
                                            endPoint: CGPoint,
                                        controlPoint1: NSPoint,
                                        controlPoint2: NSPoint,
                                            tailWidth: CGFloat,
                                            headWidth: CGFloat,
                                            headLength: CGFloat) -> NSBezierPath {
        
        let xdiff: Float = Float(endPoint.x) - Float(startPoint.x)
        let ydiff: Float = Float(endPoint.y) - Float(startPoint.y)
        let length = hypotf(xdiff, ydiff)
        
        var points = [CGPoint]()
        self.getAxisAlignedArrowPoints(&points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        
        var transform: CGAffineTransform = self.transformForStartPoint(startPoint, endPoint: endPoint, length:  CGFloat(length))
        
        var cgPath: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddLines(cgPath, &transform, points, 7)
        CGPathCloseSubpath(cgPath)
        
        // NSBezierPath
        let uiPath: NSBezierPath = NSBezierPath(CGPath: cgPath)
        return uiPath
    }
*/
    
    class func getAxisAlignedArrowPoints(inout points: Array<NSPoint>,
                                               forLength: CGFloat,
                                               tailWidth: CGFloat,
                                               headWidth: CGFloat,
                                               headLength: CGFloat ){
        
        let tailLength = forLength - headLength
        points.append(NSPoint(x: 0, y: tailWidth/2))
        points.append(NSPoint(x: tailLength, y: tailWidth/2))
        points.append(NSPoint(x: tailLength, y: headWidth/2))
        points.append(NSPoint(x: forLength, y: 0))
        points.append(NSPoint(x: tailLength, y: -headWidth/2))
        points.append(NSPoint(x: tailLength, y: -tailWidth/2))
        points.append(NSPoint(x: 0, y: -tailWidth/2))
        
    }
    
    class func transformForStartPoint(startPoint: NSPoint,
                                      endPoint: NSPoint,
                                      length: CGFloat) -> NSAffineTransformStruct{
        
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
        return NSAffineTransformStruct(m11: cosine, m12: sine, m21: -sine, m22: cosine, tX: startPoint.x, tY: startPoint.y)
        
    }
    
    class func transformForEndPoint(startPoint: NSPoint,
                                      endPoint: NSPoint,
                                      length: CGFloat) -> NSAffineTransformStruct{
        
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
        return NSAffineTransformStruct(m11: cosine, m12: sine, m21: -sine, m22: cosine, tX: endPoint.x, tY: endPoint.y)
        
    }


    class func curveWithArrow(startPoint:NSPoint,
                                endPoint:NSPoint,
                           controlPoint1:NSPoint,
                           controlPoint2:NSPoint,
                               tailWidth:CGFloat,
                               headWidth:CGFloat,
                              headLength:CGFloat) -> NSBezierPath {

/*
        let length:CGFloat = CGFloat(hypotf(Float(endPoint.x - controlPoint2.x), Float(endPoint.y - controlPoint2.y)))
        
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
       let trStruct:NSAffineTransformStruct = NSAffineTransformStruct(m11: cosine, m12: sine, m21: -sine, m22: cosine, tX: endPoint.x, tY: endPoint.y)
        //
        let tr:NSAffineTransform = NSAffineTransform().trStr
        

        //tr.transformStruct:trStruct

        
        
        
        // tr.transformStruct(trStruct)
        
        //CGAffineTransformMake
        
*/
    
    /*
        from  https://osxentwicklerforum.de/index.php/Thread/5405-Algodingsbums-Pfeilspitze-auf-Rechteck/?postID=54116&highlight=NSAffineTransform#post54116
         
         - Die Länge des Richtungsvektors normieren
         - vom Punkt an der Spitze aus <pfeilspitzenlänge> den Richtungsvektor zurückgehen
         - von dort aus <pfeilspitzenbreite/2> quer gehen ( (y/-x) ist dann ja auch auf Einheitslänge)
         - und das gleiche nochmal in die andere Richtung (-y/x) - fertig!
    */
        
    let path = NSBezierPath()
        
    NSColor.blueColor().set()
        
    // linie zeichnen
    // path.moveToPoint(controlPoint2)
    // path.lineToPoint(endPoint)
        
    // richtungsvektor berechnen
    var vd:NSPoint = NSPoint()
    vd.x = endPoint.x - controlPoint2.x;
    vd.y = endPoint.y - controlPoint2.y;
    
    // normieren
    // float len = sqrtf( (vd.x * vd.x) + (vd.y * vd.y) );
    //    vd.x /= len;
    //    vd.y /= len;
    let len:CGFloat = CGFloat(hypotf(Float(endPoint.x - controlPoint2.x), Float(endPoint.y - controlPoint2.y)))
    vd.x = vd.x/len
    vd.y = vd.y/len
    
    // zurueck gehen
    var triangleBase:NSPoint = NSPoint()
    triangleBase.x = endPoint.x - ( headLength * vd.x)
    triangleBase.y = endPoint.y - ( headLength * vd.y)
    
    // normale
    let tmp:CGFloat = -vd.x;
    vd.x = vd.y;
    vd.y = tmp;
        
    // eckpunkte berechnen
    var pe1:NSPoint = NSPoint()
    pe1.x = triangleBase.x  - ( headWidth * vd.x);
    pe1.y = triangleBase.y  - ( headWidth * vd.y);
        
    var pe2:NSPoint = NSPoint()
    pe2.x = triangleBase.x  + ( headWidth * vd.x);
    pe2.y = triangleBase.y  + ( headWidth * vd.y);
        
    // dreieck malen
    let triangle = NSBezierPath()
    
    triangle.moveToPoint(endPoint)
    triangle.lineToPoint(pe1)
    triangle.lineToPoint(pe2)
    triangle.lineToPoint(endPoint)
    //triangle.closePath()
    triangle.fill()
        
    path.appendBezierPath(triangle)
        
    // make the curve
    // path.lineWidth = tailWidth // funktioniert hier nicht
    path.moveToPoint(startPoint)
    path.curveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
    return path;
}
    
/*
    class func curveFromPointtoPointWithcontrolPoints(startPoint:NSPoint,
                                            endPoint: NSPoint,
                                            controlPoint1: NSPoint,
                                            controlPoint2: NSPoint,
                                            tailWidth: CGFloat,
                                            headWidth: CGFloat,
                                            headLength: CGFloat) -> NSBezierPath {
   
    // Helpful resources
    // http://stackoverflow.com/questions/14068862/drawing-an-arrow-with-nsbezierpath-between-two-points
    // https://gist.github.com/mayoff/4146780
    
        
    //let path:NSBezierPath = [NSBezierPath bezierPath];
    
    // Arrow length
        
    let length:CGFloat = CGFloat(hypotf(Float(endPoint.x - controlPoint2.x), Float(endPoint.y - controlPoint2.y)))
    
    // The transformation
    let cosine:CGFloat  = (endPoint.x - controlPoint2.x) / length
    let sine:CGFloat    = (endPoint.y - controlPoint2.y) / length
        
    //let transformStruct: NSAffineTransformStruct = { cosine, sine, -sine, cosine, endPoint.x, endPoint.y };
    //let transformStruct: NSAffineTransformStruct = NSAffineTransformStruct(cosine, sine, -sine, cosine, startPoint.x, startPoint.y)
        
    var transform: CGAffineTransform = self.transformForStartPoint(startPoint, endPoint: endPoint, length:  CGFloat(length))
        
    NSAffineTransform *tr = [NSAffineTransform transform];
    [tr setTransformStruct:transformStruct];
    
    // The points
    NSPoint points[kArrowPointCount];
    [self dqd_getAxisAlignedArrowPoints:points
    forLength:0 //length
    tailWidth:tailWidth
    headWidth:headWidth
    headLength:headLength];
    
    [path moveToPoint:points[0]];
    for (int i = 0; i < kArrowPointCount; i++)
    {
    [path lineToPoint:points[i]];
    }
    
    [path closePath];
    [path transformUsingAffineTransform:tr];
    
    // make the curve
    [path moveToPoint:startPoint];
    [path curveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    return path;
    
    }
}
*/

}
//
// let arrowPath = NSBezierPath.curveWithArrow(CGPointMake(0,0), CGPointMake(0,20),CGPointMake(10,0),CGPointMake(0,10) 4, 8, 6)
//

/*  ------------------ objective C ------------------

 #import "NSBezierPath+Arrowhead.h"
 
 #define kArrowPointCount 7
 
 @implementation NSBezierPath (NSBezierPath_Arrow)
 
 + (NSBezierPath *)curveFromPoint:(NSPoint)startPoint
 toPoint:(NSPoint)endPoint
 controlPoint1:(NSPoint)controlPoint1
 controlPoint2:(NSPoint)controlPoint2
 tailWidth:(CGFloat)tailWidth
 headWidth:(CGFloat)headWidth
 headLength:(CGFloat)headLength
 {
 // Helpful resources
 // http://stackoverflow.com/questions/14068862/drawing-an-arrow-with-nsbezierpath-between-two-points
 // https://gist.github.com/mayoff/4146780
 
 NSBezierPath* path = [NSBezierPath bezierPath];
 
 // Arrow length
 CGFloat length = hypotf(endPoint.x - controlPoint2.x, endPoint.y - controlPoint2.y);
 
 // The transformation
 CGFloat cosine = (endPoint.x - controlPoint2.x) / length;
 CGFloat sine = (endPoint.y - controlPoint2.y) / length;
 NSAffineTransformStruct transformStruct = { cosine, sine, -sine, cosine, endPoint.x, endPoint.y };
 NSAffineTransform *tr = [NSAffineTransform transform];
 [tr setTransformStruct:transformStruct];
 
 // The points
 NSPoint points[kArrowPointCount];
 [self dqd_getAxisAlignedArrowPoints:points
 forLength:0 //length
 tailWidth:tailWidth
 headWidth:headWidth
 headLength:headLength];
 
 [path moveToPoint:points[0]];
 for (int i = 0; i < kArrowPointCount; i++)
 {
 [path lineToPoint:points[i]];
 }
 
 [path closePath];
 [path transformUsingAffineTransform:tr];
 
 // make the curve
 [path moveToPoint:startPoint];
 [path curveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
 
 return path;
 
 }
 
 + (void)dqd_getAxisAlignedArrowPoints:(NSPoint[kArrowPointCount])points
 forLength:(CGFloat)length
 tailWidth:(CGFloat)tailWidth
 headWidth:(CGFloat)headWidth
 headLength:(CGFloat)headLength
 {
 CGFloat tailLength = length - headLength;
 points[0] = NSMakePoint(0, tailWidth / 2);
 points[1] = NSMakePoint(tailLength, tailWidth / 2);
 points[2] = NSMakePoint(tailLength, headWidth / 2);
 points[3] = NSMakePoint(length, 0);
 points[4] = NSMakePoint(tailLength, -headWidth / 2);
 points[5] = NSMakePoint(tailLength, -tailWidth / 2);
 points[6] = NSMakePoint(0, -tailWidth / 2);
 }
 
 @end
 
 */

