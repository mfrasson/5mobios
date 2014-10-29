//
//  BuscaViewController.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class BuscaViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nomePesquisaTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "toListSegue"){
            let listaResultadoController:ListaResultadoViewController = segue.destinationViewController as ListaResultadoViewController
            listaResultadoController.nomePesquisa = nomePesquisaTextView.text
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

}
