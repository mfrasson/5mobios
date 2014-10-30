//
//  CelulaCartaCustomTableViewCell.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 29/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class CelulaCartaCustomTableViewCell: UITableViewCell {
    
    private var mainText:UILabel = UILabel(frame: CGRect(x: 5, y: 5, width: 190, height: 90))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let botao:UIButton = UIButton.buttonWithType(UIButtonType.InfoDark) as UIButton
        botao.center = CGPointMake(280, 50)
        self.contentView.addSubview(botao)
        
        mainText.backgroundColor = UIColor.clearColor()
        mainText.text = ""
        self.contentView.addSubview(mainText)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCustomCell(aDict:Dictionary<String, String>) {
        self.mainText.text = aDict["nome"]
    }
}
