//
//  VariationModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 05/04/22.
//

import Foundation
import UIKit

class VariationModel : NSObject {
    
    
    var shadeId : String
    var shade_color_code : String
    var shade_name : String
    var size : [SizeModel]
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.shadeId = dictionary[kshadeId] as? String ?? ""
        self.shade_color_code = dictionary[kshade_color_code] as? String ?? ""
        self.shade_name = dictionary[kshade_name] as? String ?? ""
        self.size = (dictionary[ksize] as? [[String:Any]] ?? []).compactMap(SizeModel.init)
    
    }
}

