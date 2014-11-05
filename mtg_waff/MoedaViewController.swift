//
//  MoedaViewController.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class MoedaViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var coinImageView: UIImageView!
    var touchCoin:Bool = false
    var flag:Bool = false
    
    var animando: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura o gesto de tap via codigo
        var swipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handlerSwipe:")
        swipeGesture.delegate = self
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        
        
        
        
        self.coinImageView.addGestureRecognizer(swipeGesture)
        
        
        // Setup da moeda para animacao de giro
        self.coinImageView.animationDuration = 0.2
        self.coinImageView.animationRepeatCount = 0
        var arrImages:[UIImage] = [UIImage]()
        for (var i = 1; i <= 3; i++) {
            let img:UIImage = UIImage(named: "moeda\(i)")
            arrImages.append(img)
        }
        self.coinImageView.animationImages = arrImages
    }
    
    //MARK: - Gesture recognizers handles
    func handlerSwipe(recognizer:UISwipeGestureRecognizer) {
        
        let originalPosition:CGPoint = self.coinImageView.center
        
        if(!self.animando){
            self.animando = true;
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.coinImageView.startAnimating()
                self.coinImageView.center = CGPointMake(self.coinImageView.center.x, self.coinImageView.center.y - 375)
                }) { (completed) -> Void in
                    if(completed){
                        UIView.animateWithDuration(1.0, animations: { () -> Void in
                            self.coinImageView.center = CGPointMake(self.coinImageView.center.x, self.coinImageView.center.y + 375)
                            }) { (completed2) -> Void in
                                self.coinImageView.stopAnimating()
                                self.animando = false
                                if (arc4random_uniform(100) > 50) {
                                    self.coinImageView.image = UIImage(named: "moeda1")
                                } else {
                                    self.coinImageView.image = UIImage(named: "moeda3")
                                }
                        }
                    }
            }}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
