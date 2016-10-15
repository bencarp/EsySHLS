//
//  ViewController.swift
//  EsySHSL
//
//  Created by Peter Heynmöller on 14.10.16.
//  Copyright © 2016 p3h3. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var RenamePopupView: UIView!
    @IBOutlet var AddPopupView: UIView!
    @IBOutlet var AddPopupIpInput: UITextField!
    @IBOutlet var AddPopupNameInput: UITextField!
    @IBOutlet var Switch: UIButton!
    
    var CurrentState = false
    
    var lightSwitchSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "lseffect", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    let requests = Requests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        RenamePopupView.layer.cornerRadius = 5
        AddPopupView.layer.cornerRadius = 5
        
        //audioPlayer = AVAudioPlayer(contentsOf: lightSwitchSound as URL)
        
        
    }
    
    @IBAction func AddItem(_ sender: AnyObject) {
        
        self.view.addSubview(AddPopupView)
        AddPopupView.center = self.view.center
        
        AddPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        AddPopupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.AddPopupView.alpha = 1
            self.AddPopupView.transform = CGAffineTransform.identity
        }
        
    }
    @IBAction func RenameItem(_ sender: AnyObject) {
        
        self.view.addSubview(RenamePopupView)
        RenamePopupView.center = self.view.center
        
        RenamePopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        RenamePopupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.RenamePopupView.alpha = 1
            self.RenamePopupView.transform = CGAffineTransform.identity
        }
        
    }
    
    @IBAction func AddPopupViewConfirm(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.AddPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.AddPopupView.alpha = 0
            
        }) { (success:Bool) in
            self.AddPopupView.removeFromSuperview()
        }
        
    }
    
    @IBAction func RenamePopupViewConfirm(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.RenamePopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.RenamePopupView.alpha = 0
            
        }) { (success:Bool) in
            self.RenamePopupView.removeFromSuperview()
        }
        
    }
    @IBAction func switchLightState(_ sender: AnyObject) {
        
        CurrentState = !CurrentState
        
        if (CurrentState) {
            Switch.setTitle("Turn off.", for: UIControlState.normal)
            //requests.sendPostRequest(url: "172.26.2.220/OFF", params: "")
            requests.sendGetRequest(url: "http://172.26.2.220/ON")
        }else {
            Switch.setTitle("Turn on.", for: UIControlState.normal)
            //requests.sendPostRequest(url: "172.26.2.220/ON", params: "")
            requests.sendGetRequest(url: "http://172.26.2.220/OFF")
        }
        
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        AddPopupNameInput.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

