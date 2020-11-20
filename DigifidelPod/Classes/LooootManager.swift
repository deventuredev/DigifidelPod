//
//  LooootManagerOut.swift
//  Loooot
//
//  Created by Deventure Dev on 05/10/2020.
//  Copyright © 2020 Deventure. All rights reserved.
//

import Foundation
import Loooot
import GoogleMaps

public class LooootManager : BaseLooootManager, MapViewDelegate {
    var mapView: DigifidelMapView?
    
    public static var shared:BaseLooootManager
    {
        get
        {
            if(BaseLooootManager.sharedInstance.protoHttpManagerDelegate == nil)
            {
                BaseLooootManager.sharedInstance.protoHttpManagerDelegate = ProtoClientManager.shared
            }
            return BaseLooootManager.sharedInstance
        }
    }
    
    public func GetMapView() -> BaseMapView {
        GMSServices.provideAPIKey(LooootManager.googleMapsApiKey)
        
        return mapView!
    }
    
    private override init() {
        super.init()
    }
}
