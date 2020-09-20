//
//  Constants.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit

struct Constants {
    // MARK: - Fonts
    struct Fonts {
        static func systemFontLight(_ x: CGFloat) -> UIFont {
          return UIFont.systemFont(ofSize: x, weight: UIFont.Weight.light)
        }
       static func systemFontRegular(_ x: CGFloat) -> UIFont {
         return UIFont.systemFont(ofSize: x, weight: UIFont.Weight.regular)
       }
        static func systemFontBold(_ x: CGFloat) -> UIFont {
          return UIFont.systemFont(ofSize: x, weight: UIFont.Weight.bold)
        }
        struct Main {
            
        }
    }
    
    // MARK: - Colors
    struct Colors {
        static let BackgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.1)
        static let TintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        
        struct Main {
            
        }

    }
    
    // MARK: - DIMENSIONS
    struct Dimensions {
      static let ScreenWidth = UIScreen.main.bounds.size.width
      static let ScreenHeight = UIScreen.main.bounds.size.height
    }

}

