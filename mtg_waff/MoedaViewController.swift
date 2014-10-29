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
    var touchCoin:Bool = false
    var flag:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Recupera um toque qualquer na tela
        let touch:UITouch = touches.anyObject() as UITouch
        
        // Verifica se o dedo docima do objeto pelo toque na view geral
        if (CGRectContainsPoint(self.coinImageView.frame, touch.locationInView(self.view))) {
            self.touchCoin = true
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // Recupera um toque qualquer na tela
        let touch:UITouch = touches.anyObject() as UITouch
        
        // Pega a posicao(x,y) do toque recuperado
        let location:CGPoint = touch.locationInView(self.view)
        
        //self.touchCoin = false
        
        // Quando tocado, se mover, a moeda acompanha o movimento
        //if (self.touchCoin) {
        //    self.coinImageView.center = CGPointMake(location.x, location.y);
        //}
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let originalPosition:CGPoint = self.coinImageView.center
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            if(!self.flag){
                self.flag = true
                self.coinImageView.center = CGPointMake(self.coinImageView.center.x, self.coinImageView.center.y-375)
                self.coinImageView.startAnimating()
            }}) { (completed) -> Void in
                UIView.animateWithDuration(0.7, animations: { () -> Void in
                    self.coinImageView.center = originalPosition
                    }) { (completed) -> Void in
                        self.touchCoin = false
                        self.coinImageView.stopAnimating()
                        self.flag = false
                }
                if (arc4random_uniform(100) > 50) {
                    self.coinImageView.image = UIImage(named: "moeda1")
                } else {
                    self.coinImageView.image = UIImage(named: "moeda3")
                }
        }
        
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        self.touchCoin = false
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
