//
//  LIstaResultadoViewController.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class ListaResultadoViewController: UITableViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var cartas:Array<Dictionary<String, AnyObject>>? = nil
    var data = NSMutableData()
    
    var nomePesquisa:NSString = "Lotus"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Implementar a busca pelo nome informado na tela anterior...
        let url:NSURL = NSURL(string: "http://api.mtgapi.com/v1/card/name/" + nomePesquisa)
        
        let request:NSURLRequest = NSURLRequest(URL: url)
        
        // Invoca a requisicao de forma sincrona
        var error = NSErrorPointer()
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var data:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        
        //		//MARK: - JSON Steps
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: nil) as Array<AnyObject>
        
        self.cartas = json as? Array<Dictionary<String, AnyObject>>
        
        // TODO: Implementar a exibição do Resultado na TableView
        println(self.cartas)
        
        // Do any additional setup after loading the view. denovo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func temp(){
        
    }
}
