//
//  ViewController.swift
//  SampleTest
//
//  Created by Kamlesh Kumar on 02/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var listTableview: UITableView!
    
     let viewModel = InventeryListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inventryFetched = reloadTable
        viewModel.viewDidLoad()
        
     }
    func reloadTable(isRload:Bool) {
        print("reload table")
        self.listTableview.reloadData()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noofRows//self.inventryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InventroyItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InventroyItemTableViewCell") as! InventroyItemTableViewCell
        let celldata = viewModel.getInventryCellModel(index: indexPath.row)
        cell.populate(celldata: celldata)
        return cell
    }
    

    @IBAction func filterTapped(_ sender: Any) {
        let viewcont = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        viewcont.itemToFilterd = viewModel.applyfilter
        self.navigationController?.present(viewcont, animated: false, completion: nil)
    }
}
