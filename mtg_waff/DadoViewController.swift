//
//  DadoViewController.swift
//  mtg_waff
//
//  Created by Ronaldo Faraone on 02/11/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class DadoViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var dadoImageView: UIImageView!
    
    var touchDado:Bool = false
    var flag:Bool = false
    
    var animando: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configura o gesto de tap via codigo
        var swipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handlerSwipe:")
        swipeGesture.delegate = self
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        
        self.dadoImageView.addGestureRecognizer(swipeGesture)
        
    
    // Setup da moeda para animacao de giro

    self.dadoImageView.animationDuration = 0.2
    self.dadoImageView.animationRepeatCount = 0
    var arrImages:[UIImage] = [UIImage]()
    for (var i = 1; i <= 20; i++) {
    let img:UIImage = UIImage(named: "dice\(i)")
    arrImages.append(img)
    }
    self.dadoImageView.animationImages = arrImages
    }

    
    //MARK: - Gesture recognizers handles
    func handlerSwipe(recognizer:UISwipeGestureRecognizer) {
        
        let originalPosition:CGPoint = self.dadoImageView.center
        
        if(!self.animando){
            self.animando = true;
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.dadoImageView.startAnimating()
                self.dadoImageView.center = CGPointMake(self.dadoImageView.center.x, self.dadoImageView.center.y - 375)
                }) { (completed) -> Void in
                    if(completed){
                        UIView.animateWithDuration(1.0, animations: { () -> Void in
                            self.dadoImageView.center = CGPointMake(self.dadoImageView.center.x, self.dadoImageView.center.y + 172)
                            }) { (completed2) -> Void in
                                self.dadoImageView.stopAnimating()
                                self.animando = false
                                if (arc4random_uniform(100) > 50) {
                                    self.dadoImageView.image = UIImage(named: "dice1")
                                } else {
                                    self.dadoImageView.image = UIImage(named: "dice2")
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
