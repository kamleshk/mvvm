//
//  FetchInventryListApi.swift
//  SampleTest
//
//  Created by Kamalesh Kumar Yadav on 02/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit

class FetchInventryListApi: NSObject {
    func callInventryListApi(complition:@escaping (_ isSucces:Bool)->()) {
        let urlStr = "https://api.myjson.com/bins/12l8sb"
        guard let url = URL(string: urlStr) else {
            return complition(false)
        }
        WebserviceManager().GETRegest(url: url) { (response) in
            switch response {
            case .succes(let data) : print(data)
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                data, options: []) as! [String:Any]
                DispatchQueue.main.async { self.parseJson(attributes: jsonResponse) }
                complition(true)
            }catch{
                print("parsing failed")
                }
            case .error(let message) : print(message)
            }
        }
    }
    
    func parseJson(attributes:[String:Any])  {
        
        guard let rin = attributes["RIN"] as? [[String:Any]] else { return }
        guard let invtarr  =  rin.first?["InvList"] as? [[String:Any]] else { return }
        guard let baseUrl = attributes["blu"] as? String else {
            return
        }
        CoredataManager.shared.clearData()
        CoredataManager.shared.saveInCoreDataWith(imgBaseUrl: baseUrl, array: invtarr as [[String : AnyObject]])
        
        print(baseUrl)
        
    }
    
}
