//
//  DadoViewController.swift
//  mtg_waff
//
//  Created by Ronaldo Faraone on 02/11/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class DadoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //@IBOutlet weak var dadoImageView: UIImageView!
    
    @IBOutlet weak var diceImageView: UIImageView!
    
    var touchDado:Bool = false
    var flag:Bool = false
    
    var animando: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura o gesto de tap via codigo
        var swipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handlerSwipe:")
        swipeGesture.delegate = self
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        
        self.diceImageView.addGestureRecognizer(swipeGesture)
        
        
        // Setup do dado para animacao de giro
        
        self.diceImageView.animationDuration = 0.2
        self.diceImageView.animationRepeatCount = 0
        var arrImages:[UIImage] = [UIImage]()
        for (var i = 1; i <= 20; i++) {
            let img:UIImage = UIImage(named: "dice\(i)")
            arrImages.append(img)
            
        }
        
        self.diceImageView.animationImages = arrImages
        
    }
    
    
    //MARK: - Gesture recognizers handles
    func handlerSwipe(recognizer:UISwipeGestureRecognizer) {
        
        let originalPosition:CGPoint = self.diceImageView.center
        
        if(!self.animando){
            self.animando = true;
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.diceImageView.startAnimating()
                self.diceImageView.center = CGPointMake(self.diceImageView.center.x, self.diceImageView.center.y - 225)
                }) { (completed) -> Void in
                    if(completed){
                        UIView.animateWithDuration(1.0, animations: { () -> Void in
                            self.diceImageView.center = CGPointMake(self.diceImageView.center.x, self.diceImageView.center.y + 225)
                            }) { (completed2) -> Void in
                                self.diceImageView.stopAnimating()
                                self.animando = false
                                var randomizeDice:UInt32 = arc4random_uniform(20)
                                if (randomizeDice > 0) {
                                    self.diceImageView.image = UIImage(named: "dice\(randomizeDice)")
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
