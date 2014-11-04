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
    
    var idCarta:NSString = "3"
    var enderecoImagem:NSString = ""
    
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enderecoImagem = "http://api.mtgdb.info/content/hi_res_card_images/" + idCarta + ".jpg"

        let urlImagem:NSURL = NSURL(string: enderecoImagem)
        
        let requestImagem:NSURLRequest = NSURLRequest(URL: urlImagem)
        
        var errorImagem = NSErrorPointer()
        var responseImagem = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var dataImagem:NSData? = NSURLConnection.sendSynchronousRequest(requestImagem, returningResponse: responseImagem, error: errorImagem)

        
        imagem.image = UIImage(data: dataImagem!)
        
        self.setupCoreDataStack()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCoreDataStack(){
        // Criação do Modelo
        let modelURL:NSURL? = NSBundle.mainBundle().URLForResource("FavListModel", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOfURL: modelURL!)

        // Criação do Coordenador
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let applicationDocumentsDirectory = urls[0] as NSURL
        
        let url = applicationDocumentsDirectory.URLByAppendingPathComponent("FavListModel.sqlite")
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
    
    func addCardToFavList(){
        let entityDescripition = NSEntityDescription.entityForName("Card", inManagedObjectContext: managedObjectContext!)
        let card = Card(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
//        card.id = idCarta
//        card.nome = nomeCarta
//        card.edicao = edicaoCarta
        card.imgpath = enderecoImagem
        managedObjectContext?.save(nil)

    }
    
    func delCardFromFavList(carta:Card){
        managedObjectContext?.deleteObject(carta)
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
