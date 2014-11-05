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
        var cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as CelulaCartaCustomTableViewCell
        let card = fetchedResultController.objectAtIndexPath(indexPath) as Card
        
        cell.setupCustomCell(card)
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

    func getFetchedResultController(){
        let fetchRequest = NSFetchRequest(entityName: "Card")
        
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultController.delegate = self
        
        fetchedResultController.performFetch(nil)
    }

    

}
