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
    
    var nomePesquisa:NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trataEspacosNomePesquisa(nomePesquisa!)
        
        let url:NSURL = NSURL(string: "http://api.mtgapi.com/v1/card/name/" + nomePesquisa!)
        
        let request:NSURLRequest = NSURLRequest(URL: url)
        
        // Invoca a requisicao de forma sincrona
        var error = NSErrorPointer()
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var data:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: nil) as Array<AnyObject>
        
        self.cartas = json as? Array<Dictionary<String, AnyObject>>
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func trataEspacosNomePesquisa(texto: NSString){
        nomePesquisa = texto.stringByReplacingOccurrencesOfString(" ", withString: "%20")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let numberOfRowsInSection = fetchedResultController.fetchedObjects?.count
        return cartas!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as UITableViewCell
        
        let carta:Dictionary<String, AnyObject> = cartas![indexPath.row]
        
        cell.textLabel?.text = carta["name"]! as? String
        cell.detailTextLabel?.text = carta["id"]! as? String
        //cell.accessoryType = UITableViewCellAccessoryType.DetailButton        cell.textLabel?.text = task.nome
        return cell
    }
    

}
