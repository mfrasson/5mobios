//
//  ListaDesejoViewControllerTableViewController.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 04/11/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit
import CoreData

class ListaDesejoViewControllerTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext?
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCoreDataStack()
        
        self.getFetchedResultController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.fetchedObjects?.count
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as UITableViewCell
        let task = fetchedResultController.objectAtIndexPath(indexPath) as Card
        cell.textLabel?.text = task.nome
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
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

    func getFetchedResultController() {
        
        //Primeiro inicializamos um FetchRequest com dados da tabela Task
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        // Definimos que o campo usado para ordenação será "nome"
 //       let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
 //       fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Iniciamos a propriedade fetchedResultController com uma instância de NSFetchedResultsController
        //com o FetchRequest acima definido e sem opções de cache
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        //a controller será o delegate do fetch
        fetchedResultController.delegate = self
        
        //Executa o Fetch
        fetchedResultController.performFetch(nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
