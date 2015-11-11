source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
inhibit_all_warnings!

workspace 'Template1'
xcodeproj 'App_iOS/App_iOS.xcodeproj'
xcodeproj 'App_Mac/App_OSX.xcodeproj'
xcodeproj 'App_TV/App_TV.xcodeproj'
xcodeproj 'Core/Core.xcodeproj'

target :'App_iOS' do
    platform :ios, '8.0'
    link_with 'App_iOS', 'App_iOSTests', 'App_iOSUITests'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Typhoon'
    pod 'TwitterKit'
    pod 'AWSDynamoDB', '~> 2.2.0'
    pod 'FBSDKCoreKit'
    pod 'FBSDKLoginKit'
    pod 'FBSDKShareKit'
    pod 'Google/Analytics'
    pod 'Google/SignIn'
    pod 'Google/AdMob'
    xcodeproj 'App_iOS/App_iOS.xcodeproj'
end

target :'App_Watch Extension' do
    platform :watchos, '2.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'App_iOS/App_iOS.xcodeproj'
end

target :'App_OSX' do
    platform :osx, '10.9'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'App_OSX/App_OSX.xcodeproj'
end

target :'App_TV' do
    platform :tvos, '9.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    #pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'App_TV/App_TV.xcodeproj'
end

target :'Core_iOS' do
    platform :ios, '8.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'Core/Core.xcodeproj'
end

target :'Core_iOSTests' do
    platform :ios, '8.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'Core/Core.xcodeproj'
end

target :'Core_Watch' do
    platform :watchos, '2.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    xcodeproj 'Core/Core.xcodeproj'
end

target :'Core_OSX' do
    platform :osx, '10.9'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'Core/Core.xcodeproj'
end

target :'Core_OSXTests' do
    platform :osx, '10.9'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'Core/Core.xcodeproj'
end

target :'Core_TV' do
    platform :tvos, '9.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    #pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'Core/Core.xcodeproj'
end

target :'Core_TVTests' do
    platform :tvos, '9.0'
    pod 'RxSwift', '~> 2.0.0-beta'
    pod 'RxCocoa', '~> 2.0.0-beta'
    #pod 'RealmSwift'
    pod 'Alamofire', '~> 3.0'
    xcodeproj 'Core/Core.xcodeproj'
end
