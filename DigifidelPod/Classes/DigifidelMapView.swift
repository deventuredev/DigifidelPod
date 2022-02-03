import Foundation
import UIKit
import AVFoundation
import GoogleMaps
import Loooot
import GoogleMapsUtils
import SwiftSignalRClient
import MapKit

@IBDesignable
public class DigifidelMapView : BaseMapView, GMSMapViewDelegate, GMUClusterManagerDelegate, GMUClusterRendererDelegate, SignalRCallback {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapTypeImageView: UIImageView!
    @IBOutlet weak var mapOverlay: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tokenCollectedView: UIView!
    @IBOutlet weak var tokenCollectedRewardName: UILabel!
    @IBOutlet weak var constraintTokenCollectedRewardNameTop: NSLayoutConstraint!
    @IBOutlet weak var tokenCollectedImage: UIImageView!
    @IBOutlet weak var tokenCollectedDetails: UILabel!
    @IBOutlet weak var tokenCloseView: UIView!
    @IBOutlet weak var tokenCollectedClose: UIImageView!
    @IBOutlet weak var infoDialogView: UIView!
    @IBOutlet weak var infoDialogTitle: UILabel!
    @IBOutlet weak var cnsInfoDialogTitleTop: NSLayoutConstraint!
    @IBOutlet weak var infoDialogMessage: UILabel!
    @IBOutlet weak var infoDialogButtonContainer: UIView!
    @IBOutlet weak var cnsInfoDialogButtonContainerTop: NSLayoutConstraint!
    @IBOutlet weak var cnsInfoDialogButtonContainerBottom: NSLayoutConstraint!
    @IBOutlet weak var cnsInfoDialogButtonContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var debugLayoutText: UILabel!
    
    @IBOutlet weak var debugLayoutGetCampaigns: UIButton!
    @IBOutlet weak var debugLayoutGetTokens: UIButton!
    @IBOutlet weak var debugLayoutEndSession: UIButton!
    
    @IBOutlet weak var tokenCollectedButtonContainer: UIView!
    @IBOutlet weak var constraintTokenCollectedButtonContainerTop: NSLayoutConstraint!
    @IBOutlet weak var constraintTokenCollectedButtonContainerBottom: NSLayoutConstraint!
    
    @IBOutlet weak var cHeightAdBannerView: NSLayoutConstraint!
    
    @IBOutlet weak var cTokenCollectedCloseHeight: NSLayoutConstraint!
    @IBOutlet weak var cTokenCollectedCloseViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cTokenCollectedCloseWidth: NSLayoutConstraint!
    
    @IBAction func onDebugLayoutGetTokensPressed(_ sender: Any) {
        getLoadingView().isScreenReady = false
        getMapOverlay().isHidden = false
        getTokensByLocation()
    }
    
    @IBAction func onDebugLayoutGetCampaignsPressed(_ sender: Any) {
        refreshCampaigns()
    }
    
    @IBAction func onDebugLayoutEndSessionPressed(_ sender: Any) {
        BaseLooootManager.sharedInstance.endSession()
    }
    
    private var clusterManager: GMUClusterManager!
    private var gmsMarkers: Array<LooootMarker>! = Array<LooootMarker>()
    public var gmsMarkerSelected: GMSMarker!
    
    private var adBannerViewLocal: AdBannerView?
    private var errorViewLocal: ErrorView?
    private var loadingViewLocal: LoadingView?
    private var cHeightAdBannerViewLocal: NSLayoutConstraint?
    private var tokenCollectedButton: PrimaryButton?
    private var infoDialogButton: PrimaryButton?
    private var signalRService: SignalRService?
    
    private var currentPolygon: GMSPolygon!
    private var roomsPolygon: [GMSPolygon] = [ GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon(), GMSPolygon() ]
    private var looootMarker :LooootMarker!
    private var signalRConnectRetryCount:Int = 0

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let frameworkBundle = Bundle(for: DigifidelMapView.self)
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("DigifidelBundle.bundle")
        let bundle = Bundle(url: bundleURL!)
        loadViewFromNib(bundle: bundle!)

        initLocalViews()
        baseInit()
        initViews()
        initMaps()
        initializeSignalRService()
    }
    
    public func onTokenCollectedSignal(data: SignalRService.TokenNotifyPlayerModel) {
        onTokenCollected(tokenId: data.getTokenId(), groupId: data.getGroupId(), campaignId: data.getCampaignId())
    }
    
    public func onRefreshCampaigns() {
        self.refreshCampaigns()
    }
    
    public func connectionDidOpen(hubConnection: HubConnection) {
        if(currentLatLongIdentifier == nil || currentLatLongIdentifier == 0){
            return
        }
        
        let newRoom = "\(BaseLooootManager.sharedInstance.getClientId())-\(currentLatLongIdentifier.description)"
        signalRService?.changeRoomByLatLongIdentifier(oldRoom: "", newRoom: newRoom)

        if BaseLooootManager.sharedInstance.isDebugMode() {
            debugString[4] = "oldRoom: \(BaseLooootManager.sharedInstance.getClientId())-"
            debugString[5] = "newRoom: \(newRoom)"
            debugString[8] = "SignalR ConnectionId:" + (signalRService?.getConnectionId())!
            refreshDebugString()
        }
    }
    
    public func connectionDidFailToOpen(error: Error) {
    }
    
    public func connectionDidClose(error: Error?) {
    }
    
    public func connectionWillReconnect(error: Error?) {
        
    }
    
    public func connectionDidReconnect() {
    }
    
    /**
     Load view from bundle.
     */
    private func loadViewFromNib(bundle: Bundle) {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.setView(newView: view)
    }
        
    public override func changeMapFrame(size: CGSize)
    {
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - 48)
       
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
        errorViewLocal?.translatesAutoresizingMaskIntoConstraints = true
        errorViewLocal?.frame = bounds
        errorViewLocal?.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        getView().addSubview(errorViewLocal!)
        errorView.isHidden = true
        
        loadingViewLocal = LoadingView(frame: CGRect(x: screenBounds.width/2 - 25, y:screenBounds.height/2 - 25, width: 50, height: 50))
        getView().addSubview(loadingViewLocal!)
        loadingView.isHidden = true
        
        var buttonWidth = screenBounds.width
        if screenBounds.height < screenBounds.width {
            buttonWidth = screenBounds.height
        }
        tokenCollectedButton = PrimaryButton(frame: CGRect(x: 0, y:0, width: buttonWidth - 144, height:40))
        cTokenCollectedCloseWidth.constant = buttonWidth - 144
        tokenCollectedButtonContainer.addSubview(tokenCollectedButton!)
        tokenCollectedButton?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCloseTokenCollected(tapGestureRecognizer:))))
        
        infoDialogButton = PrimaryButton(frame: CGRect(x: 0, y:0, width: buttonWidth - 144, height:40))
        cnsInfoDialogButtonContainerWidth.constant = buttonWidth - 144
        infoDialogButtonContainer.addSubview(infoDialogButton!)
        infoDialogButton?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCloseInfoDialog(tapGestureRecognizer:))))
    }
    
    /**
     Initialize views.
     */
    private func initViews() {
        mapView.delegate = self
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        if BaseLooootManager.sharedInstance.isDebugMode() {
            // No minimum zoom
        }
        else if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            mapView.setMinZoom(BaseMapView.minimumZoomIdiomPad, maxZoom: BaseMapView.maximumZoom)
        }
        else {
            mapView.setMinZoom(BaseMapView.minimumZoom, maxZoom: BaseMapView.maximumZoom)
        }
        
        mapOverlay.backgroundColor = UIColor(hex: 0x000000, alpha: 0.6)
        tokenCollectedView.layer.cornerRadius = 4
        tokenCollectedView.backgroundColor = ThemeManager.shared.getPrimaryBackgroundColor()
        tokenCollectedClose.tintColor = ThemeManager.shared.getPrimaryColor()
        tokenCollectedRewardName.textColor = ThemeManager.shared.getPrimaryTextColor()
        tokenCollectedDetails.textColor = ThemeManager.shared.getPrimaryTextColor()
        tokenCollectedButton!.setTitle(BaseLooootManager.sharedInstance.getTranslationManager().getTranslation(key: TranslationConstants.mapViewConfirm), for: UIButton.State.normal)
        tokenCollectedView.isHidden = true
        
        infoDialogView.layer.cornerRadius = 4
        infoDialogView.backgroundColor = ThemeManager.shared.getPrimaryBackgroundColor()
        infoDialogTitle.textColor = ThemeManager.shared.getPrimaryTextColor()
        infoDialogMessage.textColor = ThemeManager.shared.getPrimaryTextColor()
        infoDialogButton!.setTitle(BaseLooootManager.sharedInstance.getTranslationManager().getTranslation(key: TranslationConstants.mapViewConfirm), for: UIButton.State.normal)
        infoDialogView.isHidden = true
        
        setUpDebugLayout()
        
        mapTypeImageView.layer.cornerRadius = 4
        mapTypeImageView.layer.borderColor = ThemeManager.shared.getNavBarBackgroundColor().cgColor
        mapTypeImageView.layer.borderWidth = 1
        mapTypeImageView.image = ThemeManager.shared.getMapTypeSatelliteViewImage()
        let mapTypeTap = UITapGestureRecognizer(target: self, action: #selector(onChangeMapType(tapGestureRecognizer:)))
        mapTypeImageView.addGestureRecognizer(mapTypeTap)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onCloseTokenCollected(tapGestureRecognizer:)))
        tokenCloseView.addGestureRecognizer(singleTap)
        tokenCollectedClose.addGestureRecognizer(singleTap)
        // Ads are stopped. Remove next line to show back
        //AdManager.shared.setViewForBanner(bannerView: adBannerViewLocal!, viewHeightConstraint: cHeightAdBannerViewLocal!)
        adBannerViewLocal?.isHidden = true
        
        //TODO: Until further changes this will remain
        cTokenCollectedCloseViewHeight.constant = 0
        cTokenCollectedCloseHeight.constant = 0
        tokenCloseView.isHidden = true
        tokenCollectedClose.isHidden = true
        
        if !BaseLooootManager.sharedInstance.isDebugMode() {
            debugLayoutText.isHidden = true
            debugLayoutGetTokens.isHidden = true
            debugLayoutGetCampaigns.isHidden = true
            debugLayoutEndSession.isHidden = true
        }
    }
    
    override public func onHomePressed() {
        signalRService?.stop()
        signalRService = nil
    }
    
    @objc private func onChangeMapType(tapGestureRecognizer: UITapGestureRecognizer) {
        if mapView.mapType == GMSMapViewType.normal {
            mapTypeImageView.image = ThemeManager.shared.getMapTypeMapViewImage()
            mapView.mapType = GMSMapViewType.satellite
        }
        else {
            mapTypeImageView.image = ThemeManager.shared.getMapTypeSatelliteViewImage()
            mapView.mapType = GMSMapViewType.normal
        }
    }
    
    @objc private func onCloseTokenCollected(tapGestureRecognizer: UITapGestureRecognizer) {
        self.onCloseTokenCollectedAction(tapGestureRecognizer: tapGestureRecognizer)
    }
    
    @objc private func onCloseInfoDialog(tapGestureRecognizer: UITapGestureRecognizer) {
        infoDialogView.isHidden = true
        mapOverlay.isHidden = true
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
    public func setCollectedViewBackgroundColor(color: UIColor) {
        tokenCollectedView.backgroundColor = color
    }
    
    /**
     This function sets the map overlay color.
     
     - parameters:
     - color: The new color.
     */
    public func setMapOverlayColor(color: UIColor) {
        mapOverlay.backgroundColor = color
    }
    
    /**
     This function sets the token close button color.
     
     - parameters:
     - color: The new color.
     */
    public func setTokenCloseColor(color: UIColor) {
        tokenCollectedClose.backgroundColor = color
    }
    
    /**
     This function sets the token claim text color.
     
     - parameters:
     - color: The new color.
     */
    public func setTokenClaimTextColor(color: UIColor) {
        tokenCollectedDetails.textColor = color
    }
    
    /**
     This function sets the add to wallet button text color.
     
     - parameters:
     - color: The new color.
     */
    public func setAddToWalletButtonTextColor(color: UIColor) {
        tokenCollectedButton!.setTitleColor(color, for: UIButton.State.normal)
    }
    
    /**
     This function sets the add to wallet button color.
     
     - parameters:
     - color: The new color.
     */
    public func setAddToWalletButtonColor(color: UIColor) {
        tokenCollectedButton!.backgroundColor = color
    }
    
    /**
     This function sets the loading color.
     
     - parameters:
     - color: The new color.
     */
    public func setLoadingViewColor(color: UIColor) {
        getLoadingView().setStrokeColor(color: color)
    }
    
    public func initMaps() {
        mapView.translatesAutoresizingMaskIntoConstraints = true
        mapView.frame = bounds
        mapView.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: [999], backgroundColors: [ThemeManager.shared.getClusterColor()])
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = CustomClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        renderer.animatesClusters = false
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
    }
    
    public override func onNetworkStatusChanged(isConnected: Bool) {
        let signalRConenction = (signalRService?.isConnected ?? false)
        if(isConnected && !signalRConenction)
        {
            initializeSignalRService()
        }
    }
    
    private func initializeSignalRService() {
        if signalRConnectRetryCount >= 5 {
            return
        }
        if !(signalRService?.isConnected ?? false) {
            signalRConnectRetryCount += 1
            signalRService = SignalRService.shared(callback: self)
            signalRService?.start()
        }
        else {
            signalRConnectRetryCount = 0
        }
    }
    
    private func addToWallet(campaignName: String, expirationDate: Date?, redeemType: Int, qrContent: String?) {
        let claimedToken = WalletList(id: self.tokenSelected.getRewardTypeId(), name: self.tokenSelected.getName(), name2: self.tokenSelected.getName2(), rewardImageUrl: self.tokenSelected.getImageUrl(), rewardType: redeemType, mapRewardId: self.tokenSelected.getId(), expirationDate: expirationDate, campaignName: campaignName, qrContent: qrContent)
        NotificationCenter.default.post(name: .rewardRedeemed, object: self, userInfo: [NotificationCenterDataConstants.rewardRedeemKey: claimedToken])
    }
    
    public override func removeMarker(mapReward: MapReward) {
        if gmsMarkers == nil
        {
            return
        }
        guard let gmsMarkerIndex = gmsMarkers.firstIndex(where: {$0.mapReward.getId() == mapReward.getId()}) else {
            print("no token found wirh id:\(mapReward.getId())")
            return
        }
        let gmsMarker = gmsMarkers[gmsMarkerIndex]
        print("TokenId: \(mapReward.getId()), GroupId: \(mapReward.getGroupId())")
        print("gmsMarkerIndex\(gmsMarkerIndex.description)")
        print("gmsMarkers.count \(gmsMarkers.count.description)")
        
        self.clusterManager.remove(gmsMarker)
        if gmsMarkerIndex < self.gmsMarkers.count
        {
            self.gmsMarkers.remove(at: gmsMarkerIndex)
        }
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
        
    
        DispatchQueue.main.async {
            self.clusterManager.add(toBeAddedGmsMarkers)
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
        var currentUserLatitude = BaseLooootManager.sharedInstance.getCurrentLatitude()! * 100
        currentUserLatitude = Double(Int(currentUserLatitude))
        currentUserLatitude = currentUserLatitude / 100
        
        var currentUserLongitutde = BaseLooootManager.sharedInstance.getCurrentLongitude()! * 100
        currentUserLongitutde = Double(Int(currentUserLongitutde))
        currentUserLongitutde = currentUserLongitutde / 100
        
        var offsetLatPlus2 = currentUserLatitude + 0.02
        var offsetLatPlus1 = currentUserLatitude + 0.01
        var ofssetLatMinus1 = currentUserLatitude - 0.01
        if currentUserLatitude < 0  {
            offsetLatPlus2 = currentUserLatitude - 0.02
            offsetLatPlus1 = currentUserLatitude - 0.01
            ofssetLatMinus1 = currentUserLatitude + 0.01
        }

        var offsetLngPlus2 = currentUserLongitutde + 0.02
        var offsetLngPlus1 = currentUserLongitutde + 0.01
        var ofssetLngMinus1 = currentUserLongitutde - 0.01
        if currentUserLongitutde < 0  {
            offsetLngPlus2 = currentUserLongitutde - 0.02
            offsetLngPlus1 = currentUserLongitutde - 0.01
            ofssetLngMinus1 = currentUserLongitutde + 0.01
        }
        
        let point1 = CLLocationCoordinate2DMake(offsetLatPlus2, ofssetLngMinus1)
        let point2 = CLLocationCoordinate2DMake(offsetLatPlus2, currentUserLongitutde)
        let point3 = CLLocationCoordinate2DMake(offsetLatPlus2, offsetLngPlus1)
        let point4 = CLLocationCoordinate2DMake(offsetLatPlus2, offsetLngPlus2)

        let point5 = CLLocationCoordinate2DMake(offsetLatPlus1, ofssetLngMinus1)
        let point6 = CLLocationCoordinate2DMake(offsetLatPlus1, currentUserLongitutde)
        let point7 = CLLocationCoordinate2DMake(offsetLatPlus1, offsetLngPlus1)
        let point8 = CLLocationCoordinate2DMake(offsetLatPlus1, offsetLngPlus2)

        let point9 = CLLocationCoordinate2DMake(currentUserLatitude, ofssetLngMinus1)
        let point10 = CLLocationCoordinate2DMake(currentUserLatitude, currentUserLongitutde)
        let point11 = CLLocationCoordinate2DMake(currentUserLatitude, offsetLngPlus1)
        let point12 = CLLocationCoordinate2DMake(currentUserLatitude, offsetLngPlus2)

        let point13 = CLLocationCoordinate2DMake(ofssetLatMinus1, ofssetLngMinus1)
        let point14 = CLLocationCoordinate2DMake(ofssetLatMinus1, currentUserLongitutde)
        let point15 = CLLocationCoordinate2DMake(ofssetLatMinus1, offsetLngPlus1)
        let point16 = CLLocationCoordinate2DMake(ofssetLatMinus1, offsetLngPlus2)
        
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
        
        DispatchQueue.main.async {
            self.clusterManager.cluster()
        }
    }
    
    public override func onArItemCollected(reward: MapReward?, arItem: ARItem) {
        if reward == nil {
            let model = SignalRService.TokenNotifyPlayerModel(tokenId: arItem.getId(), groupId: arItem.getGroupId(), campaignId: arItem.getCampaignId())
            onTokenCollectedSignal(data: model)
            setTokenCollected(rewardName: nil, message: "", collectionRules: ResponseHelper.getMessage(responseCode: ResponseCode.errorTokenAlreadyClaimed), isError: true)
            setOverlayHidden(isHidden: false)
            claimTokenBusy = false
            return
        }
       
        onTokenClicked()
    }
    
    public override func onTokenClicked() {
        if (looootMarker == nil)
        {
            return
        }

        let reward = looootMarker
        removeMarker(mapReward: reward!.mapReward)

        if BaseLooootManager.sharedInstance.isDebugMode() {
            debugString[3] = "Selected token id: \(tokenSelected.getId().description)"
            refreshDebugString()
        }

        claimToken()
    }
    
    public override func claimToken() {
        if claimTokenBusy  {
            return
        }
        claimTokenBusy = true

        let df = DateFormatter()
        df.dateFormat = StringConstants.ISODateFormat
        let currentTimeAsISO = df.string(from: Date())
        let proximity = getProximity(getCampaignId: tokenSelected.getCampaignId())
        
        BaseLooootManager.sharedInstance.getProtoHttpClient().claimToken(reward: tokenSelected, proximity: proximity, claimedAt: currentTimeAsISO,
                                                        lat: latAtClaimedTime!, lng: lngAtClaimedTime!, completion: { (data, isSuccessful) -> () in
            if data != nil {
                if !isSuccessful || data!.getStatusCode() == ResponseCode.errorCannotClaimTokensBecauseOfProximity
                        || data!.getStatusCode() == ResponseCode.errorTokenAlreadyClaimed {
                    let model = SignalRService.TokenNotifyPlayerModel(tokenId: self.tokenSelected.getId(), groupId: self.tokenSelected.getGroupId(), campaignId: self.tokenSelected.getCampaignId())
                    self.onTokenCollectedSignal(data: model)
                    
                    self.setTokenCollected(rewardName: nil, message: "", collectionRules: ResponseHelper.getMessage(responseCode: data!.getStatusCode()), isError: true)
                    self.setOverlayHidden(isHidden: false)
                    self.claimTokenBusy = false
                    return
                }
                
                let reward = data!.getData()
                if data!.getStatusCode() == ResponseCode.errorCampaignNotAvailable {
                    self.setTokenCollected(rewardName: nil, message: "", collectionRules: ResponseHelper.getMessage(responseCode: data!.getStatusCode()), isError: true)
                    self.setOverlayHidden(isHidden: false)
                    self.claimTokenBusy = false
                    
                    var campaignMinifiedList = BaseLooootManager.sharedInstance.getCampaignMinifiedList()
                    for position in 0...campaignMinifiedList.count - 1 {
                        if campaignMinifiedList[position].getId() == self.tokenSelected.getCampaignId() {
                            campaignMinifiedList.remove(at: position)
                            break
                        }
                    }
                    BaseLooootManager.sharedInstance.setCampaignMinifiedList(campaignMinifiedList: campaignMinifiedList)
                    NotificationCenter.default.post(name: .removeCampaign, object: self, userInfo: [NotificationCenterDataConstants.removeCampaign: self.tokenSelected.getCampaignId()])
                    self.removeMapTokens(campaignId: self.tokenSelected.getCampaignId())
                    return;
                    
                }
                if ResponseCode.cannotCollectMoreTokens(statusCode: data!.getStatusCode()) {
                    let model = SignalRService.TokenNotifyPlayerModel(tokenId: self.tokenSelected.getId(), groupId: self.tokenSelected.getGroupId(), campaignId:
                        self.tokenSelected.getCampaignId())
                    self.onTokenCollectedSignal(data: model)
                    
                    self.setTokenCollected(rewardName: self.tokenSelected.getFullName(), message: (reward.getMessage()!), collectionRules: "", isError: true)
                    self.setOverlayHidden(isHidden: false)
                    self.claimTokenBusy = false
                    return
                }
                
                if ResponseCode.limitReached(statusCode: data!.getStatusCode()) {
                    self.setTokenCollected(rewardName: self.tokenSelected.getFullName(), message: (reward.getMessage()!), collectionRules: (reward.getRuleLimitMessage()!), isError: true)
                    
                    var campaignMinifiedList = BaseLooootManager.sharedInstance.getCampaignMinifiedList()
                    for position in 0...campaignMinifiedList.count - 1 {
                        if campaignMinifiedList[position].getId() == self.tokenSelected.getCampaignId() {
                            self.addToWallet(campaignName: campaignMinifiedList[position].getName(), expirationDate: reward.getExpirationDate(), redeemType: reward.getRedeemType()!, qrContent: reward.getQrContent())
                            campaignMinifiedList.remove(at: position)
                            break
                        }
                    }
                    BaseLooootManager.sharedInstance.setCampaignMinifiedList(campaignMinifiedList: campaignMinifiedList)
                    NotificationCenter.default.post(name: .removeCampaign, object: self, userInfo: [NotificationCenterDataConstants.removeCampaign: self.tokenSelected.getCampaignId()])
                    self.removeMapTokens(campaignId: self.tokenSelected.getCampaignId())
                }
                else {
                    self.setTokenCollected(rewardName: self.tokenSelected.getFullName(), message: reward.getMessage()!, collectionRules: "", isError: false)
                }
                
                if reward.getRedeemType() == RedeemType.wallet || reward.getRedeemType() == RedeemType.raffle {
                    for campaignMinified in BaseLooootManager.sharedInstance.getCampaignMinifiedList() {
                        if self.tokenSelected.getCampaignId() == campaignMinified.getId() {
                            self.addToWallet(campaignName: campaignMinified.getName(), expirationDate: reward.getExpirationDate(), redeemType: reward.getRedeemType()!, qrContent: reward.getQrContent())
                            break
                        }
                    }
                }
                
                let claimTokenSignalRModel = ClaimTokenSignalRModel(companyId: BaseLooootManager.sharedInstance.getClientId(), latitude: self.tokenSelected.getLatitude(), longitude: self.tokenSelected.getLongitude(), tokenId: self.tokenSelected.getId(), groupId: self.tokenSelected.getGroupId(), campaignId: self.tokenSelected.getCampaignId())
                self.claimTokenSignalR(claimTokenSignalRModel: claimTokenSignalRModel)
                
                if BaseLooootManager.sharedInstance.getShouldGetTokensAfterClaim() {
                    DispatchQueue.main.async {
                        self.getTokensByLocation()
                    }
                }
                self.setOverlayHidden(isHidden: false)
                self.claimTokenBusy = false
            }
            else {
                self.claimTokenBusy = false
            }
        })
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
        let model = SignalRService.TokenNotifyPlayerModel(tokenId: claimTokenSignalRModel.getTokenId(), groupId: claimTokenSignalRModel.getGroupId(), campaignId: claimTokenSignalRModel.getCampaignId())
        onTokenCollectedSignal(data: model)
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
    
    public override func getTokenCollectedRewardNameLabel() -> UILabel {
        return tokenCollectedRewardName
    }
    
    override public func getConstraintTokenCollectedRewardNameTop() -> NSLayoutConstraint {
        return constraintTokenCollectedRewardNameTop
    }
    
    public override func getTokenCollectedDetailsLabel() -> UILabel {
        return tokenCollectedDetails
    }
    
    public override func getTokenCollectedImage() -> UIImageView {
        return tokenCollectedImage
    }
    
    public override func getTokenCollectedButtonContainer() -> UIView {
        return tokenCollectedButtonContainer
    }
    
    public override func getConstraintTokenCollectedButtonContainerTop() -> NSLayoutConstraint {
        return constraintTokenCollectedButtonContainerTop
    }
    
    public override func getConstraintTokenCollectedButtonContainerBottom() -> NSLayoutConstraint {
        return constraintTokenCollectedButtonContainerBottom
    }
    
    public override func getTokenCollectedButton() -> PrimaryButton {
        return tokenCollectedButton!
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
    
    public override func getInfoDialogView() -> UIView {
        return infoDialogView
    }
    
    public override func getInfoDialogTitleLabel() -> UILabel {
        return infoDialogTitle
    }
    
    public override func getConstraintInfoDialogTitleTop() -> NSLayoutConstraint {
        return cnsInfoDialogTitleTop
    }
    
    public override func getInfoDialogMessageLabel() -> UILabel {
        return infoDialogMessage
    }
    
    public override func getInfoDialogButtonContainer() -> UIView {
        return infoDialogButtonContainer
    }
    
    public override func getConstraintInfoDialogButtonContainerTop() -> NSLayoutConstraint {
        return cnsInfoDialogButtonContainerTop
    }
    
    public override func getConstraintInfoDialogButtonContainerBottom() -> NSLayoutConstraint {
        return cnsInfoDialogButtonContainerBottom
    }
    
    public override func getInfoDialogButton() -> PrimaryButton {
        return infoDialogButton!
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

public class LooootMarker: NSObject, GMUClusterItem {
    // Need to be public for GMUClusterItem.
    public var position: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    public var mapReward: MapReward
    
    public init(reward: MapReward) {
        mapReward = reward
        self.position = reward.position
        super.init()
    }
}
