//
//  MoedaViewController.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class MoedaViewController: UIViewController {

    @IBOutlet weak var coinImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup da moeda para animacao de giro
        self.coinImageView.animationDuration = 0.5
        self.coinImageView.animationRepeatCount = 0
        var arrImages:[UIImage] = [UIImage]()
        for (var i = 1; i <= 3; i++) {
            let img:UIImage = UIImage(named: "moeda\(i)")
            arrImages.append(img)
        }
        self.coinImageView.animationImages = arrImages
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func girarActionTap(sender: UIButton) {
        let angle:CGFloat = 180 / 180.0 * CGFloat(M_PI)
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.coinImageView.transform = CGAffineTransformMakeRotation(angle)
            }) { (completed) -> Void in
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.sonicImageView.transform = CGAffineTransformMakeRotation(0)
                })
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
