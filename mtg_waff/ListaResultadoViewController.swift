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
    
    var nomePesquisa: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trataEspacosNomePesquisa(nomePesquisa!)
        
        let url:NSURL = NSURL(string: "http://api.mtgdb.info/search/" + nomePesquisa! + "?start=0&limit=0")

        let request:NSURLRequest = NSURLRequest(URL: url)
        
        // Invoca a requisicao de forma sincrona
        var error = NSErrorPointer()
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var data:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: nil) as Array<AnyObject>
        
        self.cartas = json as? Array<Dictionary<String, AnyObject>>
        
        if (self.cartas!.count == 0){
            var actionSheet = UIAlertController (title: "Carta não encontrada", message:"Não foi possível encontrar a carta, favor tentar novamente!", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            actionSheet.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler: nil))
            
            self.presentViewController(actionSheet, animated: true, completion: nil)

            
            dismissViewControllerAnimated(false, completion: { () -> Void in
                
            })
        }
        
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
        return cartas!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as CelulaCartaCustomTableViewCell
        
        let carta:Dictionary<String, AnyObject> = cartas![indexPath.row]
        
        cell.setupCustomCell(carta)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "toImageViewSegue"){
            let detalheImagemController:DetalheImagemViewController = segue.destinationViewController as DetalheImagemViewController
            detalheImagemController.celulaCarta = sender as CelulaCartaCustomTableViewCell
        }
    }
}
