//
//  CelulaCartaCustomTableViewCell.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 29/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class CelulaCartaCustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nomeCarta: UILabel!
    
    @IBOutlet weak var colecaoCarta: UILabel!
    
    var idCarta: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCustomCell(carta:Dictionary<String, AnyObject>) {
        self.nomeCarta.text = carta["name"]! as? String
        self.colecaoCarta.text = carta["cardSetId"]! as? String
        let id:Int = carta["id"]! as Int
        self.idCarta = id
    }
}
