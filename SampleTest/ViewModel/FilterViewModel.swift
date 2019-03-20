//
//  FilterViewModel.swift
//  SampleTest
//
//  Created by Kamlesh Kumar on 03/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit

class FilterViewModel: NSObject {

   // var viewdidLoad :() -> () = { }
    
    
    var filterheaderArr:[FilterOptionModel] = [FilterOptionModel(title: "Rating",isselected: false),FilterOptionModel(title: "Departure",isselected: false),FilterOptionModel(title: "Fare", isselected: false),FilterOptionModel(title: "Bus Type",isselected: false)]
    
    var filterbusTyperArr:[FilterOptionModel] = [FilterOptionModel(title: "AC", isselected: false),FilterOptionModel(title: "Non AC" ,isselected: false),FilterOptionModel(title: "Sleeper", isselected: false),FilterOptionModel(title: "Seater" ,isselected: false)]
    
    override init() {
        super.init()
//        viewdidLoad {[weak self]
//
//        }
        
    }
    
    func isbustype(index:Int) -> Bool {
        let filterModel =  filterheaderArr[index]
        if filterModel.title == "Bus Type" {
            return true
        }else{
            return false
        }
    }
    
    func noofRowsInSection(section:Int) -> Int {
        if self.isbustype(index: section){
            return filterbusTyperArr.count
        }
        return 1
    }
    
    func getCellData(indexPath:IndexPath) -> FilterOptionModel  {
        if self.isbustype(index: indexPath.section){
            return filterbusTyperArr[indexPath.row]
        }else{
            return filterheaderArr[indexPath.section]
        }
    }
    
    func itemSelectedforfilter(index:IndexPath,value:Bool)  {
        
        var filterModel:FilterOptionModel?
        if self.isbustype(index: index.section){
            filterModel = filterbusTyperArr[index.row]
            filterModel?.isselected = value
            filterbusTyperArr[index.row] = filterModel!
        }else{
            filterModel = filterheaderArr[index.section]
            filterModel?.isselected = value
            filterheaderArr[index.section] = filterModel!
        }
    }
    
}
