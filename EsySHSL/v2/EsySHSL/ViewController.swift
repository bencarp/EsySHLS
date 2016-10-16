//
//  ViewController.swift
//  EsySHSL
//
//  Created by Peter Heynmöller on 14.10.16.
//  Copyright © 2016 p3h3. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var RenamePopupView: UIView!
    @IBOutlet var AddPopupView: UIView!
    @IBOutlet var AddPopupIpInput: UITextField!
    @IBOutlet var AddPopupNameInput: UITextField!
    @IBOutlet var ServoPicker: UIPickerView!
    @IBOutlet var Switch: UIButton!
    
    var CurrentState = false
    
    var lightSwitchSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "lseffect", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    let requests = Requests()
    
    var servoPickerNames: [String] = [String]()
    var servoPickerIps: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        RenamePopupView.layer.cornerRadius = 5
        AddPopupView.layer.cornerRadius = 5
        
        //audioPlayer = AVAudioPlayer(contentsOf: lightSwitchSound as URL)
        
        //Connecting Delegate & Datasource
        self.ServoPicker.dataSource = self
        self.ServoPicker.delegate = self
        
        // Input data into the Array:
        servoPickerNames = []
        servoPickerIps = []
        
    }
    
    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return servoPickerNames.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return servoPickerNames[row] + "(" + servoPickerIps[row] + ")"
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
        
        servoPickerNames.append(AddPopupNameInput.text!)
        servoPickerIps.append(AddPopupIpInput.text!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.AddPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.AddPopupView.alpha = 0
            
        }) { (success:Bool) in
            self.AddPopupView.removeFromSuperview()
        }
        
        ServoPicker.reloadComponent(0)
        
    }
    
    @IBAction func RenamePopupViewConfirm(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.RenamePopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.RenamePopupView.alpha = 0
            
        }) { (success:Bool) in
            self.RenamePopupView.removeFromSuperview()
        }
        
    }
    @IBAction func AddPopupViewCancel(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3, animations: {
            self.AddPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.AddPopupView.alpha = 0
            
        }) { (success:Bool) in
            self.AddPopupView.removeFromSuperview()
        }
        
    }
    @IBAction func RenamePopupViewCancel(_ sender: AnyObject) {
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
            Switch.setTitle("Turn off", for: UIControlState.normal)
            //requests.sendPostRequest(url: "172.26.2.220/OFF", params: "")
            requests.sendGetRequest(url: "http://" + servoPickerIps[self.ServoPicker.selectedRow(inComponent: 0)] + "/ON")
        }else {
            Switch.setTitle("Turn on", for: UIControlState.normal)
            //requests.sendPostRequest(url: "172.26.2.220/ON", params: "")
            requests.sendGetRequest(url: "http://" + servoPickerIps[self.ServoPicker.selectedRow(inComponent: 0)] + "/OFF")
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

