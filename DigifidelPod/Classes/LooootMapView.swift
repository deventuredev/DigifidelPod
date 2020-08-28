//
//  LooootMapView.swift
//  LooootSample
//
//  Created by Deventure Dev on 27/08/2020.
//  Copyright © 2020 Deventure. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import GoogleMaps
import Loooot
import GoogleMapsUtils

@IBDesignable
public class LooootMapView: BaseMapView, GMSMapViewDelegate, GMUClusterManagerDelegate, GMUClusterRendererDelegate {
   @IBOutlet weak var mapView: GMSMapView!
   @IBOutlet weak var mapOverlay: UIView!
   @IBOutlet weak var loadingView: LoadingView!
   @IBOutlet weak var tokenCollectedView: UIView!
   @IBOutlet weak var tokenCollectedCloseView: UIView!
   @IBOutlet weak var tokenCollectedClose: UIImageView!
   @IBOutlet weak var tokenCollectedImage: UIImageView!
   @IBOutlet weak var tokenCollectedDetails: UILabel!
   @IBOutlet weak var tokenCollectedButton: PrimaryButton!
   @IBOutlet weak var tokenCollectedButtonRightConstraint: NSLayoutConstraint!
   @IBOutlet weak var tokenCollectedButtonLeftConstraint: NSLayoutConstraint!
   @IBOutlet weak var adBannerView: AdBannerView!
   @IBOutlet weak var cHeightAdBannerView: NSLayoutConstraint!
   @IBOutlet weak var errorView: ErrorView!

    // For debugging
      @IBOutlet weak var debugLayoutText: UILabel!
      @IBOutlet weak var debugLayoutGetTokens: UIButton!
      @IBOutlet weak var debugLayoutGetCampaigns: UIButton!
      
      //TODO: Until further changes this will remain
      @IBOutlet weak var cTokenCollectedCloseViewHeight: NSLayoutConstraint!
      @IBOutlet weak var cTokenCollectedCloseHeight: NSLayoutConstraint!
    
    private var clusterManager: GMUClusterManager!
    private var gmsMarkers: [GMSMarker] = []

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let bundle = Bundle(for: type(of: self))
//        loadViewFromNib(bundle: bundle)
        initViews()
        initMaps()
        baseInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bundle = Bundle(for: type(of: self))
        loadViewFromNib(bundle: bundle)
        baseInit()
        initViews()
        initMaps()
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
    
    /**
        Initialize views.
        */
       private func initViews() {
           mapView.delegate = self
           mapView.settings.compassButton = true
           mapView.settings.myLocationButton = true
           mapView.isMyLocationEnabled = true
           if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
               mapView.setMinZoom(BaseMapView.minimumZoomIdiomPad, maxZoom: BaseMapView.maximumZoom)
           }
           else {
               mapView.setMinZoom(BaseMapView.minimumZoom, maxZoom: BaseMapView.maximumZoom)
           }
           mapOverlay.backgroundColor = UIColor(hex: ThemeManager.shared.getSecondaryColor(), alpha: 0.6)
           tokenCollectedView.layer.cornerRadius = 4
           tokenCollectedView.backgroundColor = UIColor(hex: ThemeManager.shared.getPrimaryBackgroundColor())
           tokenCollectedClose.tintColor = UIColor(hex: ThemeManager.shared.getPrimaryColor())
           tokenCollectedDetails.textColor = UIColor(hex: ThemeManager.shared.getTextColor())
           tokenCollectedButton.setTitle(LooootManager.shared.getTranslationManager().getTranslation(key: TranslationConstants.mapViewConfirm), for: UIButton.State.normal)
           
           #if DIGIFIDEL
           
           tokenCollectedButtonLeftConstraint.isActive = false
           tokenCollectedButtonRightConstraint.isActive = false
           
           #endif
           
           tokenCollectedView.isHidden = true
           setUpDebugLayout()
           
           let singleTap = UITapGestureRecognizer(target: self, action: #selector(onCloseTokenCollected(tapGestureRecognizer:)))
           tokenCollectedCloseView.addGestureRecognizer(singleTap)
           tokenCollectedClose.addGestureRecognizer(singleTap)
           AdManager.shared.setViewForBanner(bannerView: adBannerView, viewHeightConstraint: cHeightAdBannerView)
           
           //TODO: Until further changes this will remain
           cTokenCollectedCloseViewHeight.constant = 0
           cTokenCollectedCloseHeight.constant = 0
           tokenCollectedCloseView.isHidden = true
           tokenCollectedClose.isHidden = true
           
           if !_isDebugAssertConfiguration() && !LooootManager.shared.shouldShowDebugLayout() {
               debugLayoutText.isHidden = true
               debugLayoutGetTokens.isHidden = true
               debugLayoutGetCampaigns.isHidden = true
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
           debugString[4] = "Selected token type: "
           debugString[5] = "Selected token campaign: "
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
           tokenCollectedButton.setTitleColor(UIColor(hex: color), for: UIButton.State.normal)
       }
       
       /**
        This function sets the add to wallet button color.
        
        - parameters:
        - color: The new color.
        */
       public func setAddToWalletButtonColor(color: Int) {
           tokenCollectedButton.backgroundColor = UIColor(hex: color)
       }
       
       /**
        This function sets the loading color.
        
        - parameters:
        - color: The new color.
        */
       public func setLoadingViewColor(color: Int) {
           loadingView.setStrokeColor(color: color)
       }
       
    
    public func initMaps()
    {
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: [999], backgroundColors: [UIColor(hex: ThemeManager.shared.getClusterColor())])
       let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
       let renderer = CustomClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
       renderer.delegate = self
       renderer.animatesClusters = false
       clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
    }
    
    
    public override func addMarkersOnCluster(mapTokens: Array<MapReward>) {
        mapTokensList = mapTokens

        clusterManager.clearItems()
        clusterManager.add(self.mapTokensList)
        clusterManager.cluster()
    }
    
    public override func onTokenClicked() {
        clusterManager.remove(tokenSelected)
        clusterManager.cluster()

        debugString[3] = "Selected token id: \(tokenSelected.getId().description)"
        debugString[4] = "Selected token type: \(tokenSelected.getRewardTypeId().description)"
        debugString[5] = "Selected token campaign: \(tokenSelected.getCampaignId().description)"
        refreshDebugString()

        claimToken()
    }
    
     public override func setMarkerSize(size: CGSize) {
        markerIconSize = size
        for marker in gmsMarkers {
            marker.setIconSize(newSize: size)
        }
    }
    
    public override func setTokenCollectedImage(image: UIImage)
    {
        tokenCollectedImage.image = image
    }
    
    public override func animateMapView(zoomLevel: Float){
        mapView.animate(toZoom: zoomLevel)

    }

    public override func getErrorView() -> ErrorView
    {
        return ErrorView()
//        return errorView
    }
    
    public override func getLoadingView() -> LoadingView
       {
           return loadingView
       }

    public override func getTokenCollectedView() -> UIView
    {
        return LoadingView()
    }
    
    public override func getTokenCollectedDetailsLabel() -> UILabel
    {
        return tokenCollectedDetails
    }
    
    public override func getTokenCollectedImage() -> UIImageView
    {
        return tokenCollectedImage
    }
    
    public override func animateMapView(latitude: Double, longitude: Double, zoom: Float)
    {
        if latitude == -999999999 && longitude == -999999999 {
            mapView.animate(toZoom: zoom)
            return
        }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
       mapView.animate(to: camera)
    }
    
    public override func getDebugTextLabel() -> UILabel
    {
        return debugLayoutText
    }
    
    public override func getMapOverlay() -> UIView
    {
        return mapOverlay
    }
    
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
           currentZoomLevel = position.zoom
 
    }
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        tokenSelected = marker.userData as? MapReward
        return onMapTokenTapped(tokenSelected: tokenSelected, markerIcon: marker.icon!, markerPosition: marker.position)
    }
    
    /**
    This function is called when a marker or a cluster is about to be added to the map.
    */
    public func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
           if marker.userData is MapReward {
               // Marker is MapToken type
               let mapToken = marker.userData as! MapReward
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
}
