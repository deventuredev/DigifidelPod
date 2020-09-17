import Foundation
import UIKit
import AVFoundation
import GoogleMaps
import GoogleMapsUtils
import SwiftSignalRClient
import Loooot

@IBDesignable
public class DigifidelMapView : BaseMapView, GMSMapViewDelegate, GMUClusterManagerDelegate, GMUClusterRendererDelegate, SignalRCallback {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapOverlay: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tokenCollectedView: UIView!
    @IBOutlet weak var tokenCollectedImage: UIImageView!
    @IBOutlet weak var tokenCollectedDetails: UILabel!
    @IBOutlet weak var tokenCloseView: UIView!
    @IBOutlet weak var tokenCollectedClose: UIImageView!
    @IBOutlet weak var adBannerView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var debugLayoutText: UILabel!
    
    @IBOutlet weak var debugLayoutGetCampaigns: UIButton!
    @IBOutlet weak var debugLayoutGetTokens: UIButton!
    @IBOutlet weak var debugLayoutEndSession: UIButton!
    
    @IBOutlet weak var tokenCollectedButtonContainer: UIView!
    
    @IBOutlet weak var cHeightAdBannerView: NSLayoutConstraint!
    
    @IBOutlet weak var cTokenCollectedCloseHeight: NSLayoutConstraint!
    @IBOutlet weak var cTokenCollectedCloseViewHeight: NSLayoutConstraint!
    
    @IBAction func onDebugLayoutGetTokensPressed(_ sender: Any) {
        getLoadingView().isScreenReady = false
        getMapOverlay().isHidden = false
        getTokensByLocation()
    }
    
    @IBAction func onDebugLayoutGetCampaignsPressed(_ sender: Any) {
        refreshCampaigns()
    }
    
    @IBAction func onDebugLayoutEndSessionPressed(_ sender: Any) {
        LooootManager.shared.endSession()
    }
    
    private var clusterManager: GMUClusterManager!
    private var gmsMarkers: Array<LooootMarker>! = Array<LooootMarker>()
    public var gmsMarkerSelected: GMSMarker!
    
    private var adBannerViewLocal: AdBannerView?
    private var errorViewLocal: ErrorView?
    private var loadingViewLocal: LoadingView?
    private var cHeightAdBannerViewLocal: NSLayoutConstraint?
    private var tokenCollectedButton: UIButton?
    private var signalRService: SignalRService?
    
    private var currentPolygon: GMSPolygon!
    private var roomsPolygon: [GMSPolygon] = [ GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon() ]
    private var looootMarker :LooootMarker!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewFromNib(bundle: Bundle.main)
        initLocalViews()
        baseInit()
        initViews()
        initMaps()
        initializeSignalRService()
    }
    
    public func onTokenCollectedSignal(data: SignalRService.TokenNotifyPlayerModel) {
        onTokenCollected(tokenId: data.getTokenId(), groupId: data.getGroupId(), campaignId: data.getCampaignId())
    }
    
    public func connectionDidOpen(hubConnection: HubConnection) {
        if(currentLatLongIdentifier == nil || currentLatLongIdentifier == 0){
            return
        }
        
        let newRoom = "\(LooootManager.shared.getClienId())-\(currentLatLongIdentifier.description)"
        signalRService?.changeRoomByLatLongIdentifier(oldRoom: "", newRoom: newRoom)

        if LooootManager.shared.isDebugMode() {
            debugString[4] = "oldRoom: \(LooootManager.shared.getClienId())-"
            debugString[5] = "newRoom: \(newRoom)"
            debugString[8] = "SignalR ConnectionId:" + (signalRService?.getConnectionId())!
            refreshDebugString()
        }
    }
    
    public func connectionDidFailToOpen(error: Error) {
    }
    
    public func connectionDidClose(error: Error?) {
    }
    
    /**
     Load view from bundle.
     */
    private func loadViewFromNib(bundle: Bundle) {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.setView(newView: view)
    }
    
    public override func initLocalViews() {
        let screenBounds = UIScreen.main.bounds
        adBannerViewLocal = AdBannerView(frame: CGRect(x: 0, y:0, width:screenBounds.width - 20, height:138))
        adBannerViewLocal?.layer.cornerRadius = 4
        adBannerViewLocal?.translatesAutoresizingMaskIntoConstraints = false
        cHeightAdBannerViewLocal = NSLayoutConstraint(item: adBannerViewLocal!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 138)
        adBannerViewLocal?.addConstraint(cHeightAdBannerViewLocal!)
        
        getView().addSubview(adBannerViewLocal!)
        adBannerViewLocal!.leadingAnchor.constraint(equalTo: getView().leadingAnchor, constant: 10).isActive = true
        adBannerViewLocal!.trailingAnchor.constraint(equalTo: getView().trailingAnchor, constant: -10).isActive = true
        var bottomPadding = CGFloat(80)
        if #available(iOS 11.0, *) {
            if UIApplication.shared.keyWindow != nil {
                bottomPadding += UIApplication.shared.keyWindow!.safeAreaInsets.bottom
            }
        }
        
        adBannerViewLocal!.bottomAnchor.constraint(equalTo: getView().bottomAnchor, constant: -bottomPadding).isActive = true
        adBannerView.isHidden = true
        
        errorViewLocal = ErrorView(frame: CGRect(x:0, y: 0, width: screenBounds.width, height: screenBounds.height))
        getView().addSubview(errorViewLocal!)
        errorView.isHidden = true
        
        loadingViewLocal = LoadingView(frame: CGRect(x: screenBounds.width/2 - 25, y:screenBounds.height/2 - 25, width: 50, height: 50))
        getView().addSubview(loadingViewLocal!)
        loadingView.isHidden = true
        
        tokenCollectedButton = PrimaryButton(frame: CGRect(x: 0, y:0, width: screenBounds.width - 144, height:40))
        tokenCollectedButtonContainer.addSubview(tokenCollectedButton!)
        tokenCollectedButton?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCloseTokenCollected(tapGestureRecognizer:))))
    }
    
    /**
     Initialize views.
     */
    private func initViews() {
        mapView.delegate = self
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        if LooootManager.shared.isDebugMode() {
            // No minimum zoom
        }
        else if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            mapView.setMinZoom(BaseMapView.minimumZoomIdiomPad, maxZoom: BaseMapView.maximumZoom)
        }
        else {
            mapView.setMinZoom(BaseMapView.minimumZoom, maxZoom: BaseMapView.maximumZoom)
        }
        
        mapOverlay.backgroundColor = UIColor(hex: ThemeManager.shared.getCellBackgroundColor(), alpha: 0.6)
        tokenCollectedView.layer.cornerRadius = 4
        tokenCollectedView.backgroundColor = UIColor(hex: ThemeManager.shared.getPrimaryBackgroundColor())
        tokenCollectedClose.tintColor = UIColor(hex: ThemeManager.shared.getPrimaryColor())
        tokenCollectedDetails.textColor = UIColor(hex: ThemeManager.shared.getTextColor())
        tokenCollectedButton!.setTitle(LooootManager.shared.getTranslationManager().getTranslation(key: TranslationConstants.mapViewConfirm), for: UIButton.State.normal)
        
        //               #if DIGIFIDEL
        //
        //               tokenCollectedButtonLeftConstraint.isActive = false
        //               tokenCollectedButtonRightConstraint.isActive = false
        //
        //               #endif
        
        tokenCollectedView.isHidden = true
        setUpDebugLayout()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onCloseTokenCollected(tapGestureRecognizer:)))
        tokenCloseView.addGestureRecognizer(singleTap)
        tokenCollectedClose.addGestureRecognizer(singleTap)
        AdManager.shared.setViewForBanner(bannerView: adBannerViewLocal!, viewHeightConstraint: cHeightAdBannerViewLocal!)
        
        //TODO: Until further changes this will remain
        cTokenCollectedCloseViewHeight.constant = 0
        cTokenCollectedCloseHeight.constant = 0
        tokenCloseView.isHidden = true
        tokenCollectedClose.isHidden = true
        
        if !LooootManager.shared.isDebugMode() {
            debugLayoutText.isHidden = true
            debugLayoutGetTokens.isHidden = true
            debugLayoutGetCampaigns.isHidden = true
            debugLayoutEndSession.isHidden = true
        }
    }
    
    @objc private func onCloseTokenCollected(tapGestureRecognizer: UITapGestureRecognizer) {
        self.onCloseTokenCollectedAction(tapGestureRecognizer: tapGestureRecognizer)
    }
    
    private func setUpDebugLayout() {
        debugLayoutText.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
        
        debugString[0] = "Current location: "
        debugString[1] = "Prev position distance: "
        debugString[2] = "Distance to selected Token: "
        debugString[3] = "Selected token id: "
        debugString[4] = "oldRoom:  "
        debugString[5] = "newRoom: "
        debugString[6] = "Session id: "
        debugString[7] = "Player Identifier: "
        debugString[8] = "SignalR connectionId: "
    }
    
    /**
     This function sets the view background color.
     
     - parameters:
     - color: The new color.
     */
    public func setCollectedViewBackgroundColor(color: Int) {
        tokenCollectedView.backgroundColor = UIColor(hex: color)
    }
    
    /**
     This function sets the map overlay color.
     
     - parameters:
     - color: The new color.
     */
    public func setMapOverlayColor(color: Int) {
        mapOverlay.backgroundColor = UIColor(hex: color)
    }
    
    /**
     This function sets the token close button color.
     
     - parameters:
     - color: The new color.
     */
    public func setTokenCloseColor(color: Int) {
        tokenCollectedClose.backgroundColor = UIColor(hex: color)
    }
    
    /**
     This function sets the token claim text color.
     
     - parameters:
     - color: The new color.
     */
    public func setTokenClaimTextColor(color: Int) {
        tokenCollectedDetails.textColor = UIColor(hex: color)
    }
    
    /**
     This function sets the add to wallet button text color.
     
     - parameters:
     - color: The new color.
     */
    public func setAddToWalletButtonTextColor(color: Int) {
        tokenCollectedButton!.setTitleColor(UIColor(hex: color), for: UIButton.State.normal)
    }
    
    /**
     This function sets the add to wallet button color.
     
     - parameters:
     - color: The new color.
     */
    public func setAddToWalletButtonColor(color: Int) {
        tokenCollectedButton!.backgroundColor = UIColor(hex: color)
    }
    
    /**
     This function sets the loading color.
     
     - parameters:
     - color: The new color.
     */
    public func setLoadingViewColor(color: Int) {
        getLoadingView().setStrokeColor(color: color)
    }
    
    public func initMaps() {
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: [999], backgroundColors: [UIColor(hex: ThemeManager.shared.getClusterColor())])
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = CustomClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        renderer.animatesClusters = false
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
    }
    
    private func initializeSignalRService() {
        signalRService = SignalRService.shared(callback: self)
        signalRService?.start()
    }
    
    public override func removeMarker(mapReward: MapReward) {
        guard let gmsMarkerIndex = gmsMarkers.firstIndex(where: {$0.mapReward.getId() == mapReward.getId()}) else { return}
        let gmsMarker = gmsMarkers[gmsMarkerIndex]
        gmsMarkers.remove(at: gmsMarkerIndex)
        clusterManager.remove(gmsMarker)
        DispatchQueue.main.async {
            self.clusterManager.cluster()
        }
    }
    
    public func updateMarkersOnCluster(newItems: Array<MapReward>, toBeRemoved:Array<MapReward>) {
        let toBeRemovedGmsMarkers = gmsMarkers.filter {
            let mapRew = $0.mapReward
            return toBeRemoved.contains(where: { $0.getId() == mapRew.getId()})
        }
        
        for clusterItem in toBeRemovedGmsMarkers {
            clusterManager.remove(clusterItem)
        }
        
        gmsMarkers = gmsMarkers.filter {
            let mapRew = $0.mapReward
            return !toBeRemoved.contains(where: { $0.getId() == mapRew.getId()})
        }
        
        var toBeAddedGmsMarkers = Array<LooootMarker>()
        for token in newItems {
            let clusterItem = LooootMarker(reward: token)
            gmsMarkers.append(clusterItem)
            toBeAddedGmsMarkers.append(clusterItem)
        }
        
        clusterManager.add(toBeAddedGmsMarkers)
        DispatchQueue.main.async {
            self.clusterManager.cluster()
        }
    }
    
    public override func updateLatLongIdentifier(oldRoom: String, newRoom: String) {
        signalRService?.changeRoomByLatLongIdentifier(oldRoom: oldRoom, newRoom: newRoom)
    }
    
    public override func drawPolygonOnMap(minX: Double, maxX: Double, minY: Double, maxY:Double) {
        drawRooms()
        
        if currentPolygon != nil {
            currentPolygon?.map = nil
        }
        
        currentPolygon = GMSPolygon()
        let rect = GMSMutablePath()
        rect.add(CLLocationCoordinate2DMake(minY, minX))
        rect.add(CLLocationCoordinate2DMake(maxY, minX))
        rect.add(CLLocationCoordinate2DMake(maxY, maxX))
        rect.add(CLLocationCoordinate2DMake(minY, maxX))
        
        currentPolygon.path = rect
        currentPolygon.strokeColor = UIColor.red
        currentPolygon.strokeWidth = 4
        currentPolygon.fillColor = UIColor.clear
        
        currentPolygon.map = mapView
    }
    
    public override func drawRooms() {
        var currentUserLatitude = LooootManager.shared.getCurrentLatitude()! * 100
        currentUserLatitude = Double(Int(currentUserLatitude))
        currentUserLatitude = currentUserLatitude / 100
        
        var currentUserLongitutde = LooootManager.shared.getCurrentLongitude()! * 100
        currentUserLongitutde = Double(Int(currentUserLongitutde))
        currentUserLongitutde = currentUserLongitutde / 100
        
        let point1 = CLLocationCoordinate2DMake(currentUserLatitude + 0.02, currentUserLongitutde - 0.01)
        let point2 = CLLocationCoordinate2DMake(currentUserLatitude + 0.02, currentUserLongitutde)
        let point3 = CLLocationCoordinate2DMake(currentUserLatitude + 0.02, currentUserLongitutde + 0.01)
        let point4 = CLLocationCoordinate2DMake(currentUserLatitude + 0.02, currentUserLongitutde + 0.02)

        let point5 = CLLocationCoordinate2DMake(currentUserLatitude + 0.01, currentUserLongitutde - 0.01)
        let point6 = CLLocationCoordinate2DMake(currentUserLatitude + 0.01, currentUserLongitutde)
        let point7 = CLLocationCoordinate2DMake(currentUserLatitude + 0.01, currentUserLongitutde + 0.01)
        let point8 = CLLocationCoordinate2DMake(currentUserLatitude + 0.01, currentUserLongitutde + 0.02)

        let point9 = CLLocationCoordinate2DMake(currentUserLatitude, currentUserLongitutde - 0.01)
        let point10 = CLLocationCoordinate2DMake(currentUserLatitude, currentUserLongitutde)
        let point11 = CLLocationCoordinate2DMake(currentUserLatitude, currentUserLongitutde + 0.01)
        let point12 = CLLocationCoordinate2DMake(currentUserLatitude, currentUserLongitutde + 0.02)

        let point13 = CLLocationCoordinate2DMake(currentUserLatitude - 0.01, currentUserLongitutde - 0.01)
        let point14 = CLLocationCoordinate2DMake(currentUserLatitude - 0.01, currentUserLongitutde)
        let point15 = CLLocationCoordinate2DMake(currentUserLatitude - 0.01, currentUserLongitutde + 0.01)
        let point16 = CLLocationCoordinate2DMake(currentUserLatitude - 0.01, currentUserLongitutde + 0.02)
        
        for i in 0 ..< roomsPolygon.count {
            roomsPolygon[i].map = nil
            roomsPolygon[i] = GMSPolygon()
            roomsPolygon[i].strokeColor = UIColor.blue
            roomsPolygon[i].strokeWidth = 4
            roomsPolygon[i].fillColor = UIColor.clear
        }
        
        var rect = GMSMutablePath()
        rect.add(point1)
        rect.add(point2)
        rect.add(point6)
        rect.add(point5)
        roomsPolygon[0].path = rect
        roomsPolygon[0].map = mapView
        
        rect = GMSMutablePath()
        rect.add(point2)
        rect.add(point3)
        rect.add(point7)
        rect.add(point6)
        roomsPolygon[1].path = rect
        roomsPolygon[1].map = mapView

        rect = GMSMutablePath()
        rect.add(point3)
        rect.add(point4)
        rect.add(point8)
        rect.add(point7)
        roomsPolygon[2].path = rect
        roomsPolygon[2].map = mapView

        rect = GMSMutablePath()
        rect.add(point5)
        rect.add(point6)
        rect.add(point10)
        rect.add(point9)
        roomsPolygon[3].path = rect
        roomsPolygon[3].map = mapView

        rect = GMSMutablePath()
        rect.add(point6)
        rect.add(point7)
        rect.add(point11)
        rect.add(point10)
        roomsPolygon[4].path = rect
        roomsPolygon[4].map = mapView

        rect = GMSMutablePath()
        rect.add(point7)
        rect.add(point8)
        rect.add(point12)
        rect.add(point11)
        roomsPolygon[5].path = rect
        roomsPolygon[5].map = mapView

        rect = GMSMutablePath()
        rect.add(point9)
        rect.add(point10)
        rect.add(point14)
        rect.add(point13)
        roomsPolygon[6].path = rect
        roomsPolygon[6].map = mapView

        rect = GMSMutablePath()
        rect.add(point10)
        rect.add(point11)
        rect.add(point15)
        rect.add(point14)
        roomsPolygon[7].path = rect
        roomsPolygon[7].map = mapView

        rect = GMSMutablePath()
        rect.add(point11)
        rect.add(point12)
        rect.add(point16)
        rect.add(point15)
        roomsPolygon[8].path = rect
        roomsPolygon[8].map = mapView
    }
    
    public override func addMarkersOnCluster(mapTokens: Array<MapReward>) {
        mapTokensList = mapTokens
        
        clusterManager.clearItems()
        gmsMarkers = Array<LooootMarker>()
        
        for token in mapTokens {
            let clusterItem = LooootMarker(reward: token)
            gmsMarkers.append(clusterItem)
        }
        clusterManager.add(gmsMarkers)
        clusterManager.cluster()
    }
    
    public override func onTokenClicked() {
        if (looootMarker == nil)
        {
            return
        }

        let reward = looootMarker
        removeMarker(mapReward: reward!.mapReward)
       
        if LooootManager.shared.isDebugMode() {
            debugString[3] = "Selected token id: \(tokenSelected.getId().description)"
            refreshDebugString()
        }
        
        claimToken()
    }
    
    public override func setMarkerSize(size: CGSize) {
        markerIconSize = size
        //            for marker in gmsMarkers {
        //                marker.setIconSize(newSize: size)
        //            }
    }
    
    public override func setTokenCollectedImage(image: UIImage) {
        tokenCollectedImage.image = image
    }
    
    public override func animateMapView(zoomLevel: Float){
        mapView.animate(toZoom: zoomLevel)
    }
    
    public override func whenAutoUpdateMap() {
        if !(signalRService?.isConnected ?? true) {
            signalRService?.start()
        }
    }
    
    public override func claimTokenSignalR(claimTokenSignalRModel: ClaimTokenSignalRModel) {
        signalRService?.onClaimToken(claimTokenModel: claimTokenSignalRModel)
    }
    
    public override func startSignalRService() {
        if !(signalRService?.isConnected ?? true) {
            signalRService?.start()
        }
    }
    
    public override func stopSignalRService() {
        signalRService?.stop()
    }
    
    public override func getErrorView() -> ErrorView {
        return errorViewLocal!
    }
    
    public override func getLoadingView() -> LoadingView {
        return loadingViewLocal!
    }
    
    public override func getTokenCollectedView() -> UIView {
        return tokenCollectedView
    }
    
    public override func getTokenCollectedDetailsLabel() -> UILabel {
        return tokenCollectedDetails
    }
    
    public override func getTokenCollectedImage() -> UIImageView {
        return tokenCollectedImage
    }
    
    public override func animateMapView(latitude: Double, longitude: Double, zoom: Float) {
        if latitude == -999999999 && longitude == -999999999 {
            mapView.animate(toZoom: zoom)
            return
        }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        mapView.animate(to: camera)
    }
    
    public override func getDebugTextLabel() -> UILabel {
        return debugLayoutText
    }
    
    public override func getMapOverlay() -> UIView {
        return mapOverlay
    }
    
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        currentZoomLevel = position.zoom
    }
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        gmsMarkerSelected = marker
        let loootMarker = marker.userData as? LooootMarker
        self.looootMarker = loootMarker
        tokenSelected =  loootMarker?.mapReward
        return onMapTokenTapped(mapTokenSelected: loootMarker?.mapReward, markerIcon: marker.icon, markerPosition: marker.position)
    }
    
    /**
     This function is called when a marker or a cluster is about to be added to the map.
     */
    public func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        if marker.userData is LooootMarker {
            // Marker is MapToken type
            let loootToken = marker.userData as! LooootMarker
            let mapToken = loootToken.mapReward
            marker.title = mapToken.getName()
            
            if !ImageCacher.shared.containsUrl(imageUrl: mapToken.getImageUrl()) {
                SDWebImageManager.shared.loadImage(with: URL(string: mapToken.getImageUrl()), options: SDWebImageOptions.progressiveLoad, progress: nil) { (image, data, error, cacheType, x, imageUrl)  -> () in
                    ImageCacher.shared.addToDictionary(imageUrl: mapToken.getImageUrl(), image: image!)
                    marker.icon = image
                    marker.setIconSize(newSize: self.markerIconSize)
                }
            }
            else {
                marker.icon = ImageCacher.shared.getFromDictionary(imageUrl: mapToken.getImageUrl())
                marker.setIconSize(newSize: self.markerIconSize)
            }
        }
        else {
            // Marker is cluster type
            marker.setIconSize(newSize: CGSize(width: 40, height: 40))
        }
    }
    
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            shouldMoveCameraToUserPosition = false
        }
    }
    
    public func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        shouldMoveCameraToUserPosition = true
        return false;
    }
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let position = position.target;
        
        let mapTokens = getClosestMarkers(tokens: &self.allTokensList, lat: position.latitude, lng: position.longitude)
        
        var newItems = Array<MapReward>(mapTokens);
        newItems.removeAll(where:{(mapTokensList?.contains($0))!});
        
        var toBeRemoved = Array<MapReward>(mapTokensList!);
        toBeRemoved.removeAll(where:{(mapTokens.contains($0))});
        
        mapTokensList.removeAll(where:{(toBeRemoved.contains($0))});
        mapTokensList.append(contentsOf: newItems);
        
        updateMarkersOnCluster(newItems: newItems, toBeRemoved: toBeRemoved);
    }
}

public class LooootMarker: NSObject, GMUClusterItem
{
    // Need to be public for GMUClusterItem.
    public var position: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    public var mapReward: MapReward
    
    public init(reward: MapReward) {
        mapReward = reward
        self.position = reward.position
        super.init()
    }
}
