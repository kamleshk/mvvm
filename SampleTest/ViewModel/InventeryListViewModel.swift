//
//  InventeryListViewModel.swift
//  SampleTest
//
//  Created by Kamlesh Kumar on 03/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit

class InventeryListViewModel: NSObject {
var viewDidLoad: () -> () = { }
    var inventryFetched: ((Bool)-> Void )?
    
   private var inventryArr:[Inventory] = [Inventory]()
    var noofRows:Int {
        get{
            return inventryArr.count
        }
    }
    
    
    override init() {
        super.init()
       // self.dataFetcher = dataFetcher
        viewDidLoad = { [weak self] in
            self?.fetchFromStorage(filterBy: nil, sortBy: [])
            self?.getInventryfromApi()
        }
    }
    
    private func getInventryfromApi() {
        FetchInventryListApi().callInventryListApi {  (isReload) in
            if isReload {
                DispatchQueue.main.async {
                    self.fetchFromStorage(filterBy: nil, sortBy: [])
                }
                
            }
        }
    }
    
  private  func fetchFromStorage(filterBy:NSPredicate?,sortBy:[NSSortDescriptor]) {
        self.inventryArr =  CoredataManager.shared.fetchRecored(entityName: "Inventory", filterBy: filterBy, soretBy: sortBy) as! [Inventory]
        self.inventryFetched!(true)
    }
    
    func applyfilter(filters:[FilterOptionModel]) {
         var predicateStr = String()
         var sortArr = [NSSortDescriptor]()
        for  item in filters {
            if ["AC","Non AC","Seater","Sleeper"].contains( item.title) {
               predicateStr = self.getpredicates(item: item)
            }else{
                sortArr = self.getsortDisc(item: item)
            }
        }
        if predicateStr.isEmpty {
            fetchFromStorage(filterBy: nil, sortBy: sortArr)
        }else{
            fetchFromStorage(filterBy: NSPredicate(format: predicateStr), sortBy: sortArr)
        }
    }
    
  private func getpredicates(item:FilterOptionModel) -> String {
        var predicateStr = String()
        if !predicateStr.isEmpty {
            predicateStr.append("||")
        }
        switch item.title {
        case "AC": predicateStr.append("busTypeAc == 1")
        case "Non AC" : predicateStr.append("busTypeNonAc == 1")
        case "Sleeper":predicateStr.append("bustypeSl == 1")
        case "Seater": predicateStr.append("busTypeSeat == 1")
        default:break
        }
        return predicateStr
    }
    
    func getsortDisc(item:FilterOptionModel) -> [NSSortDescriptor] {
        var sortArr = [NSSortDescriptor]()
        switch item.title {
        case "Rating": let dec = NSSortDescriptor(key: "rating", ascending: false)
        sortArr.append(dec)
        case "Departure": let dec = NSSortDescriptor(key: "deptTime", ascending: false)
        sortArr.append(dec)
        case "Fare": let dec = NSSortDescriptor(key: "busFair", ascending: false)
        sortArr.append(dec)
        default:break
        }
        return sortArr
    }
    
    
    func getInventryCellModel(index:Int) -> InventryCellModel {
        let inventry = self.inventryArr[index]
        
        var celldata = InventryCellModel()
        celldata.busfare = self.priceAttibutes(priceText: inventry.busFair, currencySyambol: inventry.currency ?? "$")
        
        celldata.descBus = self.subLabel(celldata: inventry)
        celldata.headingtitle = inventry.travelsName
        celldata.ratings = String(inventry.rating)
        celldata.imageUrl = inventry.imageUrl
        return celldata
    }
    
    
    func priceAttibutes(priceText:Double,currencySyambol:String) -> NSAttributedString {
        let mutableAttrString = NSMutableAttributedString()
        let price = String(priceText) + "  "
        mutableAttrString.append( self.getAttributedString(text: currencySyambol, fontsize: 20))
        mutableAttrString.append( self.getAttributedString(text: price, fontsize: 19))
        return mutableAttrString
    }
    
    
    func subLabel(celldata:Inventory) -> NSAttributedString {
        // Create a blank attributed string
        let mutableAttrString = NSMutableAttributedString()
        
        // create attributed string
        var acString = "\n"
        acString = acString + (celldata.busTypeAc ? " AC," : "")
        acString = acString + (celldata.busTypeNonAc ? " Non AC," : "")
        acString = acString + (celldata.bustypeSl ? " SL," : "")
        acString = acString + (celldata.busTypeSeat ? " Seater" : "")
        acString.append("\n\n")
        
        mutableAttrString.append(self.getAttributedString(text: acString, fontsize: 12))
        var source = ""
        
        if let src = celldata.source {
            source =   source + "Source: " + src + ""
        }
        if let dest = celldata.destination {
            source = source + "    Destination: " + dest  + "\n\n"
        }
        mutableAttrString.append(self.getAttributedString(text: source, fontsize: 12))
        
        if let arr = celldata.arivalTime{
            if !arr.isEmpty{
                let date:Date = arr.toDate(withFormat: "dd/MM/yyyy HH:mm:ss a")!
                let arivaltime = date.toString(withFormat: "dd/MM/yyyy HH:mm:ss a")
                mutableAttrString.append(self.getAttributedString(text: "Arrival Time:\(arivaltime)\n\n", fontsize: 12))
            }
        }
        
        if let arr = celldata.deptTime{
            let arivaltime = arr.toString(withFormat: "dd/MM/yyyy HH:mm:ss a")
            mutableAttrString.append(self.getAttributedString(text: "Departure Time:\(arivaltime)\n\n", fontsize: 12))
        }
        return mutableAttrString
    }
    
    func getAttributedString(text:String,fontsize:Int) -> NSAttributedString {
        let myAttribute: [NSAttributedString.Key : Any] = [ NSAttributedString.Key.font: UIFont(name: "Helvetica", size: CGFloat(fontsize)) ?? UIFont() ]
        let myAttrString = NSAttributedString(string: text, attributes: myAttribute)
        return myAttrString
    }
    
}

struct InventryCellModel {
    var busfare:NSAttributedString?
    var descBus:NSAttributedString?
    var imageUrl:String?
    var headingtitle:String?
    var ratings:String?
}
