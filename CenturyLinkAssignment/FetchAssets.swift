//
//  FetchAssets.swift
//  CenturyLinkAssignment
//
//  Created by Swagat Mishra on 4/22/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation
import UIKit

class FetchAssets {
    
    let domain = "http://asset-api-master.centurylink.digital/asset/stocks"
    
    func fetchAssets(completion: @escaping ([Assets]) -> Void) {
        guard let assetsUrl = URL(string: domain) else { return }
        
        let task = URLSession.shared.dataTask(with: assetsUrl) { (data, response, error) in
            
            if error != nil {
                completion([])
            }
            
            guard let responseData = data else { return }
            if let assets = try? JSONDecoder().decode([Assets].self, from: responseData) {
                completion(assets)
            }
        }
        task.resume()
    }
}

