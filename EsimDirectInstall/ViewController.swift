//
//  ViewController.swift
//  EsimDirectInstall
//
//  Created by Azamat Kushmanov on 22/7/24.
//

import UIKit
import AppBoxoSDK

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup config
        let config = Config(clientId: "CLIENT_ID")
        Appboxo.shared.setConfig(config: config)
    }
    
    @IBAction func launchMiniapp(_ sender: Any) {
        let miniapp = Appboxo.shared.getMiniapp(appId: "MINIAPP_ID")
        miniapp.delegate = self
        miniapp.open(viewController: self)
    }
    
}

extension ViewController : MiniappDelegate {
    func didReceiveCustomEvent(miniapp: Miniapp, customEvent: CustomEvent) {
        if customEvent.type == "esim_direct_install" {
            guard let urlString = customEvent.payload?["url"] as? String, let url = URL(string: urlString) else { return }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

