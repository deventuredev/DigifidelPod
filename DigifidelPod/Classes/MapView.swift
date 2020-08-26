//
//  MapView.swift
//  Pods-DigifidelPod_Tests
//
//  Created by Deventure Dev on 26/08/2020.
//

import Foundation
import GoogleMaps

public class MapView: UIView {
    private let googleMapsApiKey = "asd"

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
       GMSServices.provideAPIKey(googleMapsApiKey)
                 let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
                let mapView = GMSMapView.map(withFrame: frame, camera: camera)
                addSubview(mapView)

                // Creates a marker in the center of the map.
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
                marker.title = "Sydney"
                marker.snippet = "Australia"
                marker.map = mapView
    }
}

