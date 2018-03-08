//
//  ViewController.swift
//  LogSample
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Logger.shared.info(category: "UI", message: "Info Log!", debugModeOnly: true)
        Logger.shared.debug(category: "UI", message: "Debug Log!", debugModeOnly: true)
        Logger.shared.error(category: "UI", message: "Error Log!", debugModeOnly: true)
        Logger.shared.fault(category: "UI", message: "Fault Log!", debugModeOnly: true)
        Logger.shared.default(category: "UI", message: "Default Log!", debugModeOnly: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

