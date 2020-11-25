// Generated by Apple Swift version 5.3.1 (swiftlang-1200.0.41 clang-1200.0.32.8)
#ifndef LOOOOT_SWIFT_H
#define LOOOOT_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(ns_consumed)
# define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
#else
# define SWIFT_RELEASES_ARGUMENT
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import ARKit;
@import CoreGraphics;
@import CoreLocation;
@import CoreMedia;
@import Foundation;
@import ObjectiveC;
@import SceneKit;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="Loooot",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

@class NSCoder;

/// This UIView is used to display banner ad.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot12AdBannerView")
@interface AdBannerView : UIView
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
@end

@class NSBundle;

/// This UIViewController is used to display interstitial ad.
/// It displays a close button after a number of seconds after ad was displayed.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot28AdInterstitialViewController")
@interface AdInterstitialViewController : UIViewController
/// This function sets ad image and initializes the timer for close button.
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


/// This node type enables the client to have access to the view or image that
/// was used to initialize the <code>LocationAnnotationNode</code>.
SWIFT_CLASS("_TtC6Loooot14AnnotationNode")
@interface AnnotationNode : SCNNode
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


/// This UIView is used to display a map with tokens to collect on it.
/// It displays tokens based on current location. Tokens are clustered on map.
/// When a token is clicked, if the phone supports AR, it will open camera and will add the token in camera view. If the phone doesn’t support AR it will just collect the token.
/// After the token was collected, it will disappear from map and it will be added to wallet.
/// If there is no internet connection or if location or camera permissions are disabled or if location service is disabled it will display an ErrorView screen.
SWIFT_CLASS("_TtC6Loooot11BaseMapView")
@interface BaseMapView : UIView
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
@end



@class UITableView;
@class UITableViewCell;

/// This UIView is used to display the list of campaigns or a no campaigns message if the list is empty.
/// If there is no internet connection or the location permission is disabled it will display an ErrorView screen.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot16CampaignListView")
@interface CampaignListView : UIView <UITableViewDataSource, UITableViewDelegate>
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
/// Fill data in table view row.
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
/// Table view row tap action.
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
@end


/// This is a UITableViewCell that is used to display informations about a campaign.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot21CampaignTableViewCell")
@interface CampaignTableViewCell : UITableViewCell
/// Initialize views.
- (void)awakeFromNib;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC6Loooot22CustomBottomNavigation")
@interface CustomBottomNavigation : UITabBar
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@end


IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot30DigiFidelCampaignTableViewCell")
@interface DigiFidelCampaignTableViewCell : UITableViewCell
/// Initialize views.
- (void)awakeFromNib;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot34DigiFidelExtendedItemTableViewCell")
@interface DigiFidelExtendedItemTableViewCell : UITableViewCell
- (void)awakeFromNib;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot32DigiFidelSimpleItemTableViewCell")
@interface DigiFidelSimpleItemTableViewCell : UITableViewCell
- (void)awakeFromNib;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end



/// This view displays errors with image and message.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot9ErrorView")
@interface ErrorView : UIView
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
@end


/// This is a UITableViewCell that contains image, title, subtitle and message.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot25ExtendedItemTableViewCell")
@interface ExtendedItemTableViewCell : UITableViewCell
/// Initialize views.
- (void)awakeFromNib;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end

@class CAShapeLayer;

/// This UIView is used to display a continuous circular loading bar.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot11LoadingView")
@interface LoadingView : UIView
@property (nonatomic, readonly, strong) CAShapeLayer * _Nonnull layer;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly) Class _Nonnull layerClass;)
+ (Class _Nonnull)layerClass SWIFT_WARN_UNUSED_RESULT;
- (void)layoutSubviews;
- (void)didMoveToWindow;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


/// A location node can be added to a scene using a coordinate.
/// Its scale and position should not be adjusted, as these are used for scene
/// layout purposes.  To adjust the scale and position of items within a node,
/// you can add them to a child node and adjust them there
SWIFT_CLASS("_TtC6Loooot12LocationNode")
@interface LocationNode : SCNNode
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC6Loooot22LocationAnnotationNode")
@interface LocationAnnotationNode : LocationNode
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


/// Handles retrieving the location and heading from CoreLocation
/// Does not contain anything related to ARKit or advanced location
SWIFT_CLASS("_TtC6Loooot15LocationManager")
@interface LocationManager : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class CLLocationManager;
@class CLLocation;
@class CLHeading;

@interface LocationManager (SWIFT_EXTENSION(Loooot)) <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateHeading:(CLHeading * _Nonnull)newHeading;
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager * _Nonnull)manager SWIFT_WARN_UNUSED_RESULT;
@end



/// This class is used to manage location changes.
SWIFT_CLASS("_TtC6Loooot15LocationService")
@interface LocationService : NSObject <CLLocationManagerDelegate>
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// This function is called when the location is updated.
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
/// This function is called when the location update is failing.
- (void)locationManager:(CLLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nonnull)error;
/// This function is called when the location permission changes authorization.
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
@end

@class UITabBarItem;

SWIFT_CLASS("_TtC6Loooot20LooootViewController")
@interface LooootViewController : UITabBarController
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)tabBar:(UITabBar * _Nonnull)tabBar didSelectItem:(UITabBarItem * _Nonnull)item;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


/// This class is the model for the reward that is displayed on map.
SWIFT_CLASS("_TtC6Loooot9MapReward")
@interface MapReward : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC6Loooot14NetworkManager")
@interface NetworkManager : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC6Loooot24PermissionViewController")
@interface PermissionViewController : UIViewController <CLLocationManagerDelegate>
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


/// A Node that is used to show directions in AR-CL.
SWIFT_CLASS("_TtC6Loooot12PolylineNode")
@interface PolylineNode : LocationNode
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end



/// This is the primary button that the user can tap or click to perform an action.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot13PrimaryButton")
@interface PrimaryButton : UIButton
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@end


/// This UIView is used to display the details of the token.
/// If there is no internet connection it will display an ErrorView screen.
/// If the token is collected by the user it will display a redeem button that gives the user the chance to use it.
/// After the token has been used it will disappear from the user’s wallet.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot17RewardDetailsView")
@interface RewardDetailsView : UIView
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
@end


/// This UIViewController is used to display the details of a reward.
/// It contains a CouponDetailsView.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot27RewardDetailsViewController")
@interface RewardDetailsViewController : UIViewController <UINavigationBarDelegate>
/// This function initializes the data for the reward and set the navigation bar title and icon.
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


/// This UIView is used to display the list of tokens from a campaign or a no tokens message if the list is empty.
/// If there is no internet connection it will display an ErrorView screen.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot14RewardListView")
@interface RewardListView : UIView <UITableViewDataSource, UITableViewDelegate>
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
/// Fill data in table view row.
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
/// Table view row tap action.
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
@end

@protocol UIViewControllerTransitionCoordinator;

SWIFT_CLASS("_TtC6Loooot24RewardListViewController")
@interface RewardListViewController : UIViewController
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator> _Nonnull)coordinator;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


/// This UIViewController is used to display a list of tokens.
/// It contains a TokenListView.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot20RewardViewController")
@interface RewardViewController : UIViewController <UINavigationBarDelegate>
/// This function initializes the list of tokens and set the navigation bar title and icon.
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


@protocol ARSCNViewDelegate;

SWIFT_CLASS("_TtC6Loooot17SceneLocationView") SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface SceneLocationView : ARSCNView
/// Addresses <a href="https://github.com/ProjectDent/ARKit-CoreLocation/issues/196">Issue #196</a> -
/// Delegate issue when assigned to self (no location nodes render).   If the user
/// tries to set the delegate, perform an assertionFailure and tell them to set the <code>arViewDelegate</code> instead.
@property (nonatomic, strong) id <ARSCNViewDelegate> _Nullable delegate;
- (nonnull instancetype)initWithFrame:(CGRect)frame options:(NSDictionary<NSString *, id> * _Nullable)options OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
@end


@protocol SCNSceneRenderer;
@class ARAnchor;

SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface SceneLocationView (SWIFT_EXTENSION(Loooot)) <ARSCNViewDelegate>
- (SCNNode * _Nullable)renderer:(id <SCNSceneRenderer> _Nonnull)renderer nodeForAnchor:(ARAnchor * _Nonnull)anchor SWIFT_WARN_UNUSED_RESULT;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer didAddNode:(SCNNode * _Nonnull)node forAnchor:(ARAnchor * _Nonnull)anchor;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer willUpdateNode:(SCNNode * _Nonnull)node forAnchor:(ARAnchor * _Nonnull)anchor;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer didUpdateNode:(SCNNode * _Nonnull)node forAnchor:(ARAnchor * _Nonnull)anchor;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer didRemoveNode:(SCNNode * _Nonnull)node forAnchor:(ARAnchor * _Nonnull)anchor;
@end

@class SCNScene;

SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface SceneLocationView (SWIFT_EXTENSION(Loooot))
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer didRenderScene:(SCNScene * _Nonnull)scene atTime:(NSTimeInterval)time;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer updateAtTime:(NSTimeInterval)time;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer didApplyAnimationsAtTime:(NSTimeInterval)time;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer didSimulatePhysicsAtTime:(NSTimeInterval)time;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer didApplyConstraintsAtTime:(NSTimeInterval)time;
- (void)renderer:(id <SCNSceneRenderer> _Nonnull)renderer willRenderScene:(SCNScene * _Nonnull)scene atTime:(NSTimeInterval)time;
@end

@class ARSession;
@class ARCamera;

SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface SceneLocationView (SWIFT_EXTENSION(Loooot))
- (void)session:(ARSession * _Nonnull)session didFailWithError:(NSError * _Nonnull)error;
- (void)session:(ARSession * _Nonnull)session cameraDidChangeTrackingState:(ARCamera * _Nonnull)camera;
- (void)sessionWasInterrupted:(ARSession * _Nonnull)session;
- (void)sessionInterruptionEnded:(ARSession * _Nonnull)session;
- (BOOL)sessionShouldAttemptRelocalization:(ARSession * _Nonnull)session SWIFT_WARN_UNUSED_RESULT SWIFT_AVAILABILITY(ios,introduced=11.3);
- (void)session:(ARSession * _Nonnull)session didOutputAudioSampleBuffer:(CMSampleBufferRef _Nonnull)audioSampleBuffer;
@end


@class UITapGestureRecognizer;

SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface SceneLocationView (SWIFT_EXTENSION(Loooot))
- (void)sceneLocationViewTouchedWithSender:(UITapGestureRecognizer * _Nonnull)sender;
@end


/// This is the secondary button that the user can tap or click to perform an action.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot15SecondaryButton")
@interface SecondaryButton : UIButton
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@end


/// This is the UITableViewCell that contains image, title and subtitle.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot23SimpleItemTableViewCell")
@interface SimpleItemTableViewCell : UITableViewCell
/// Initialize views.
- (void)awakeFromNib;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWebView;

SWIFT_CLASS("_TtC6Loooot32TermsAndConditionsViewController")
@interface TermsAndConditionsViewController : UIViewController <UIWebViewDelegate>
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
- (void)webViewDidFinishLoad:(UIWebView * _Nonnull)webView;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end











/// This view displays the list of tokens from the wallet.
IB_DESIGNABLE
SWIFT_CLASS("_TtC6Loooot10WalletView")
@interface WalletView : UIView <UITableViewDataSource, UITableViewDelegate>
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
/// Fill data in table view row.
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
/// Table view row tap action.
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC6Loooot21WelcomeViewController")
@interface WelcomeViewController : UIViewController
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif
