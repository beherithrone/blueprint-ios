//
//  ApplicationAssembly.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//
import Core
import Typhoon

public class ApplicationAssembly: TyphoonAssembly {
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Bootstrapping
    //-------------------------------------------------------------------------------------------
    
    public var appModel: AppModel!
    
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
            
            definition.injectProperty("appModel", with: self.getAppModel())
        }
    }
    
    public dynamic func menuController() -> AnyObject {
        return TyphoonDefinition.withClass(MenuViewController.self) {
            (definition) in
            //definition.scope = TyphoonScope.Singleton;
            definition.injectProperty("appModel", with: self.getAppModel())
        }
    }
    
    public dynamic func getAppModel() -> AnyObject {
        
        return TyphoonDefinition.withClass(AppModel.self) {
            (definition) in
            definition.scope = TyphoonScope.Singleton;

            /*definition.useInitializer("initWithCityDao:theme:") {
                (initializer) in
                
                initializer.injectParameterWith(self.coreComponents.cityDao())
                initializer.injectParameterWith(self.themeAssembly.currentTheme())
            }
            definition.injectProperty("assembly")*/
        }
        
    }

    
    
    
    
    
}