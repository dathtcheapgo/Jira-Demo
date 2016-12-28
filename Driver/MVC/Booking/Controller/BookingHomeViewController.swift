//
//  BookingHomeViewController.swift
//  Driver
//
//  Created by Tien Dat on 11/9/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import UIKit

class BookingHomeViewController: BaseViewController {
    
    @IBOutlet weak var topBar: BookingTopBar!
    
    @IBOutlet weak var viewSwitchBG: HBorderView!
    
    
    @IBOutlet weak var viewSwitchHandle: UIView!
    
    
    @IBOutlet weak var lbSwitchStatus: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.layoutIfNeeded()
        
        viewSwitchBG.layer.cornerRadius = viewSwitchBG.frame.size.height/2 + 1
        viewSwitchHandle.layer.cornerRadius = viewSwitchHandle.frame.size.height/2
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.screen = .offline
        
        // Do any additional setup after loading the view.
    
        
        
        
        
        let panGest = UIPanGestureRecognizer(target: self, action: #selector(slide))
        viewSwitchHandle.isUserInteractionEnabled = true
        viewSwitchHandle.addGestureRecognizer(panGest)
        
    }


    
    


    func slide( sender: UIPanGestureRecognizer){
        let location = sender.location(in: viewSwitchBG)
        let translation = sender.translation(in: viewSwitchBG)
        let velocity = sender.velocity(in: viewSwitchBG)
       
        if sender.state == .began {
            
        } else if sender.state == .changed {
            //viewSwitchHandle.frame.origin.x = translation.x
            if velocity.x > 0 {
                UIView.animate(withDuration: 2, animations: {
                
                    self.viewSwitchHandle.constraintLead()?.constant = self.viewSwitchBG.frame.size.width - self.viewSwitchHandle.frame.size.width
                    self.viewSwitchBG.backgroundColor = UIColor(netHex: 0x004AFF)
                    
                    self.lbSwitchStatus.textAlignment = .left
                    self.lbSwitchStatus.text = "Online"
                    self.topBar.screen = .online
                    self.loadViewIfNeeded()
                })
            
            } else {
                UIView.animate(withDuration: 1, animations: {
                    self.viewSwitchHandle.constraintLead()?.constant = 0
                    
                    self.viewSwitchBG.backgroundColor = UIColor(netHex: 0x878787)
                   
                    self.lbSwitchStatus.textAlignment = .right
                    self.lbSwitchStatus.text = "Offline"
                    self.topBar.screen = .offline
                    
                })
            }
        } else if sender.state == .ended {
        print("Gesture ended")
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

