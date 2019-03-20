//
//  WebserviceManager.swift
//  SampleTest
//
//  Created by Kamalesh Kumar Yadav on 02/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit

class WebserviceManager: NSObject {

    func GETRegest(url:URL, complition:@escaping (_ result:RequestResult)->()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard error == nil else { return complition(.error(error!.localizedDescription)) }
            guard let data = data else { return complition(.error(error?.localizedDescription ?? "There are no new Items to show"))}
                if error == nil{
                    complition(.succes(data))
                }else{
                    complition(.error(error as! String))
                }
        }).resume()
    }
}

enum RequestResult {
    case succes(Data)
    case error(String)
    
}
