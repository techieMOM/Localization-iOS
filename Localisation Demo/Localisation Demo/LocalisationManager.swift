//
//  LocalisationManager.swift
//  Localisation Demo
//
//  Created by SOWJI on 05/09/20.
//  Copyright © 2020 Techie MOM by SOWJI. All rights reserved.
//

import Foundation
var bundleKey: UInt8 = 0

var languages = [("English","en"),("Telugu","te")]

class LocalisationManager  {

    class func localisedString(_ value : String) -> String {
        return NSLocalizedString(value, comment: "")
    }
    class var selectedLanguage : String {
        let languageData = languages.filter{$0.1 == LocalData.getLanguage(LocalData.language)}
        return languageData.count > 0 ? LocalData.getLanguage(LocalData.language) : "en"
    }
   
}

class BundleManager : Bundle {
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
            let bundle = Bundle(path: path) else {
                
                return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    
    class func setLanguage(_ language: String) {
        LocalData.saveLanguage(language, LocalData.language)
        defer {
            object_setClass(Bundle.main, BundleManager.self)
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
