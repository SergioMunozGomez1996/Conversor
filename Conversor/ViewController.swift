//
//  ViewController.swift
//  Conversor
//
//  Created by Otto Colomina Pardo on 20/10/17.
//  Copyright © 2017 Universidad de Alicante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let conversor = ConversorEUR_USD()

    @IBOutlet weak var dolares: UITextField!
    @IBOutlet weak var euros: UITextField!
    
    @IBOutlet weak var tipoCambioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        suscribirse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func calcularUSDPulsado(_ sender: Any) {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        if let numEuros = nf.number(from: self.euros.text!) {
            let euros = Float(truncating:numEuros)
            let dolares = conversor.cuantosUSDson(eur: euros)
            self.dolares.text = String(dolares)
        }
    }
    
   
    @IBAction func calcularEURPulsado(_ sender: Any) {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        if let numDolares = nf.number(from: self.dolares.text!) {
            let dolares = Float(truncating:numDolares)
            let euros = conversor.cuantosEURson(usd: dolares)
            self.euros.text = String(euros)
        }
    }
    
    func suscribirse() {
            let nc = NotificationCenter.default
            //primer parámetro: añadimos como observador a nosotros (self)
            //selector: al recibir la notificación se llama al método recibir
            //name: nombre de la notificación que nos interesa
            //object: objeto del que nos interesa recibir notificaciones. nil == cualquiera
            nc.addObserver(self, selector:#selector(self.recibir), name:NSNotification.Name(rawValue:"cambio moneda"), object: nil)

        }

        @objc func recibir(notificacion:Notification) {
            if let userInfo = notificacion.userInfo {
                let cambio = userInfo["cambioActual"] as! Float
                self.tipoCambioLabel.text = "1€=\(String(cambio))$"
            }
        }
}

