//
//  DetalheImagemViewController.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit
import CoreData

class DetalheImagemViewController: UIViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSFetchedResultsControllerDelegate {
    var arrCarta:Array<Dictionary<String, AnyObject>>? = nil
    
    @IBOutlet var imagem: UIImageView!
    @IBOutlet weak var desejoButton: UIButton!
    
    var celulaCarta: CelulaCartaCustomTableViewCell!
    var enderecoImagem:NSString = ""
    var managedObjectContext: NSManagedObjectContext?
    var desejado: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enderecoImagem = "http://api.mtgdb.info/content/hi_res_card_images/" + String(celulaCarta.idCarta) + ".jpg"
        
        let urlImagem:NSURL = NSURL(string: enderecoImagem)
        
        let requestImagem:NSURLRequest = NSURLRequest(URL: urlImagem)
        
        var errorImagem = NSErrorPointer()
        var responseImagem = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var dataImagem:NSData? = NSURLConnection.sendSynchronousRequest(requestImagem, returningResponse: responseImagem, error: errorImagem)
        
        imagem.image = UIImage(data: dataImagem!)
        
        self.setupCoreDataStack()
        
        let addFave = UIImage(named: "addFave")
        let removeFave = UIImage(named: "removeFave")
        self.desejoButton.setImage((self.desejado) ? addFave : removeFave, forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCoreDataStack(){
        // Criação do Modelo
        var modelURL:NSURL? = NSBundle.mainBundle().URLForResource("FavListModel", withExtension: "momd")
        var model = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        // Criação do Coordenador
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        var urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        var applicationDocumentsDirectory = urls[0] as NSURL
        
        var url = applicationDocumentsDirectory.URLByAppendingPathComponent("FavListModel.sqlite")
        var error: NSError? = nil
        
        var store = coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error)
        
        if store == nil {
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            return
        }
        
        // Criação do contexto
        managedObjectContext = NSManagedObjectContext()
        managedObjectContext!.persistentStoreCoordinator = coordinator
        
    }
    
    
    @IBAction func addCardToFavList(sender: UIButton) {
        let entityDescripition = NSEntityDescription.entityForName("Card", inManagedObjectContext: managedObjectContext!)
        let card = Card(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        card.id = celulaCarta.idCarta
        card.nome = celulaCarta.nomeCarta.text!
        card.edicao = celulaCarta.edicaoCarta.text!
        card.imgpath = enderecoImagem
        managedObjectContext?.save(nil)
    }
    
    /*
    func addCardToFavList(){
        let entityDescripition = NSEntityDescription.entityForName("Card", inManagedObjectContext: managedObjectContext!)
        let card = Card(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        card.id = celulaCarta.idCarta
        card.nome = celulaCarta.nomeCarta.text!
        card.edicao = celulaCarta.edicaoCarta.text!
        card.imgpath = enderecoImagem
        managedObjectContext?.save(nil)
        
    }
    */
    
    func delCardFromFavList(carta:Card){
        managedObjectContext?.deleteObject(carta)
    }
    
}
