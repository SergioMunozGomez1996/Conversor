//
//  ConversorEUR_USD.swift
//  Conversor
//
//  Created by Otto Colomina Pardo on 20/10/17.
//  Copyright © 2017 Universidad de Alicante. All rights reserved.
//

import Foundation

class ConversorEUR_USD {
    var unEURenUSD : Float = 0.0
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {
            timer in
            self.actualizarTipo()
        }
    }
    
    func cuantosUSDson(eur:Float)->Float {
        return eur*self.unEURenUSD
    }
    func cuantosEURson(usd:Float)->Float {
        return usd/self.unEURenUSD
    }
    func actualizarTipo() {
        //Esto se debería consultar a algún servidor.
        //Lo simulamos con un valor aleatorio
        self.unEURenUSD = Float((100.0+Double(arc4random()%50))/100.0);
        enviar(cambio: self.unEURenUSD)
        print("Cambio actual: \(self.unEURenUSD)");
    }
    
    func enviar(cambio:Float) {
        //Obtenemos el centro de notificaciones por defecto
        //Las notificaciones tienen un nombre, un objeto que las envía (si lo ponemos a nil no queda constancia de quién) y datos adicionales, un diccionario con los datos que queramos
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "cambio moneda"), object: nil, userInfo: ["cambioActual":cambio])
    }
}
