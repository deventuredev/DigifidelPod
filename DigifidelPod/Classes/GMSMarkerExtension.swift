//
//  GMSMarkerExtension.swift
//  Pods-DigifidelPod_Tests
//
//  Created by Deventure Dev on 28/08/2020.
//

import Foundation
import GoogleMaps

public extension GMSMarker {
    /**
     This function sets the icon size of the marker.
     */
    func setIconSize(newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
