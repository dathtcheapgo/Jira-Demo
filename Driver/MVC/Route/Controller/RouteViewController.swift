//
//  RouteViewController.swift
//  Driver
//
//  Created by Tien Dat on 11/8/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import UIKit
import Pulsator
class RouteViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hard-code
        Timer.scheduledTimer(timeInterval: 2, target: self,
                             selector: #selector(self.moveToIntroduce),
                             userInfo: nil, repeats: false)
        setupPulsator()
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveToIntroduce() {
        performSegue(withIdentifier: "Register", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Setup UI
extension RouteViewController {
    func setupPulsator() {
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        let pulsator = Pulsator()
        pulsator.frame = CGRect(x: width/2, y: height * 1.08, width: 0, height: 0)
        view.layer.addSublayer(pulsator)
        
        pulsator.numPulse = 3
        pulsator.radius = width
        pulsator.backgroundColor = UIColor.white.cgColor
        
        pulsator.start()
    }
}
