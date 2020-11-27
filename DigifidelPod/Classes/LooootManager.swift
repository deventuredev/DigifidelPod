import Foundation
import Loooot
import GoogleMaps

public class LooootManager : BaseLooootManager, MapViewDelegate {
    var mapView: DigifidelMapView?
    
    public static var shared:BaseLooootManager
    {
        get
        {
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
