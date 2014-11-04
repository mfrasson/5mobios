//
//  DetalheImagemViewController.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import UIKit

class DetalheImagemViewController: UIViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var arrCarta:Array<Dictionary<String, AnyObject>>? = nil
    
    @IBOutlet var imagem: UIImageView!
    
    var celulaCarta: CelulaCartaCustomTableViewCell!
    
    var idCarta:NSString = "3"
    var enderecoImagem:NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Implementar a busca pelo id da carta selecionada na tela anterior...
//        let urlDetalhe:NSURL = NSURL(string: "http://api.mtgapi.com/v1/card/id/" + idCarta)
        
//        let requestDetalhe:NSURLRequest = NSURLRequest(URL: urlDetalhe)
        
        // Invoca a requisicao de forma sincrona
//        var errorDetalhe = NSErrorPointer()
//        var responseDetalhe = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
//        var dataDetalhe:NSData? = NSURLConnection.sendSynchronousRequest(requestDetalhe, returningResponse: responseDetalhe, error: errorDetalhe)
        
        //		//MARK: - JSON Steps
//        var json = NSJSONSerialization.JSONObjectWithData(dataDetalhe!, options: NSJSONReadingOptions.allZeros, error: nil) as Array<AnyObject>
        
//        self.arrCarta = json as? Array<Dictionary<String, AnyObject>>
        
        // TODO: Implementar a exibição do Resultado na TableView
        //println(arrCarta?[0]["image"])
        
//        var cartaDic = arrCarta?[0]
        
        //self.enderecoImagem = cartaDic!["image"]! as String
        self.enderecoImagem = "http://api.mtgdb.info/content/hi_res_card_images/" + idCarta + ".jpg"

        // Do any additional setup after loading the view.
        //imagem = UIImage(data: NSData)
        
        let urlImagem:NSURL = NSURL(string: enderecoImagem)
        
        let requestImagem:NSURLRequest = NSURLRequest(URL: urlImagem)
        
        var errorImagem = NSErrorPointer()
        var responseImagem = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var dataImagem:NSData? = NSURLConnection.sendSynchronousRequest(requestImagem, returningResponse: responseImagem, error: errorImagem)

        
        imagem.image = UIImage(data: dataImagem!)
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
