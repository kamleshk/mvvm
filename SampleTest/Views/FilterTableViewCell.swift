//
//  FilterTableViewCell.swift
//  SampleTest
//
//  Created by Kamlesh Kumar on 02/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
    var itemselected: ((_ cell:UITableViewCell,_ value:Bool) -> Void)?
    
    
    override func awakeFromNib() {
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func populateCell(cellData:FilterOptionModel)  {
       
        if cellData.isselected{
        self.checkBtn.setTitle("uncheck", for: .normal)
        }else{
             self.checkBtn.setTitle("check", for: .normal)
        }
        self.titleLbl.text = cellData.title
    }
    
    @IBAction func checkBtnTapped(_ sender: Any) {
        let btn = sender as! UIButton
        guard let selected =  itemselected else { return}
        if btn.currentTitle == "check" {
            btn.setTitle("uncheck", for: .normal)
            selected(self, true)
        }else{
           btn.setTitle("check", for: .normal)
            selected(self, false)
        }
        
        
        
        
    }
    
    
}

