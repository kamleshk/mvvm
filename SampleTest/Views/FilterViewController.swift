//
//  FilterViewController.swift
//  SampleTest
//
//  Created by Kamlesh Kumar on 02/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterTableview: UITableView!
    
    
    
    var itemToFilterd : ((_ filterar:[FilterOptionModel]) -> Void)?
    let viewmodel = FilterViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //viewmodel.viewdidLoad()
    }
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewmodel.filterheaderArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.noofRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FilterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell") as! FilterTableViewCell
        cell.itemselected = itemSelectedforfilter
        let cellData = viewmodel.getCellData(indexPath: indexPath)
        cell.populateCell(cellData: cellData)
        return cell
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (viewmodel.filterheaderArr[section]).title
    }
    
    
    @IBAction func applyBtnTapped(_ sender: Any) {
        
    var filterdArr:[FilterOptionModel] = viewmodel.filterheaderArr.filter { $0.isselected == true}
        let filterBus:[FilterOptionModel] = viewmodel.filterbusTyperArr.filter{ $0.isselected == true}
        filterdArr.append(contentsOf: filterBus)
        self.itemToFilterd!(filterdArr)
        self.dismiss(animated: false, completion: nil)
    }
    
    func itemSelectedforfilter(cell:UITableViewCell,value:Bool)  {
        print(cell)
        let index: IndexPath = self.filterTableview.indexPath(for: cell) ?? IndexPath(row: 0, section: 0)
        viewmodel.itemSelectedforfilter(index: index, value: value)
    }
}
    
struct FilterOptionModel {
    let title:String
    var isselected:Bool = false

}

