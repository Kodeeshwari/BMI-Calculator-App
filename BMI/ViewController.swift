//
//  ViewController.swift
//  BMI
//
//  Created by francais on 2023-02-02.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtHeight: UITextField!
    
    @IBOutlet weak var txtWeight: UITextField!
    
    
    @IBOutlet weak var lblResult: UILabel!
    
    let bmiRange : Array<Range<Double>> = [0..<18.4,18.5..<25,25.1..<30.0,30..<100]
    let bmiClassification : Array<String> = ["Underweight", "Normal weight", "Overweight","Obesity"]
    
    let bmiColorValue :Array<UIColor> = [.systemBlue,.green,.yellow,.orange]
    
    @IBAction func calculateBmiClassification(_ sender: Any) {
        
        guard let height = Double(txtHeight.text!), height>=80, height<=250 else{
            Toast.ok(view: self, title: " Check Height ", message: "Height should be number value between 80 and 250", handler: nil)
            return
        }
        guard let weight = Double(txtWeight.text!),weight>=30,weight<=300 else{
            Toast.ok(view: self, title: " Check Weight ", message: "Weight should be number value between 30 and 300", handler: nil)
            return
        }
            
            let bmi:Double = (bmiCalculate(weight,height))
                           
            let bmiClassification  = bmiClassification(bmi)
            
            lblResult.isHidden = false
            lblResult.text = bmiClassification.bmiClassification
            lblResult.textColor = UIColor.white
            lblResult.backgroundColor = bmiClassification.colorValue
 
    }
    
    ///Calculate BMI
    func bmiCalculate( _ weight : Double, _ height : Double) -> Double{
        
        let heightInMeters = Double(height)/100
        let bmi : Double = weight / (heightInMeters * heightInMeters);
        let finalBmi = Double(String(format: "%.1f", bmi)) ?? 0
        return finalBmi;
        
    }

    /// Classification of bmi according to range
    func bmiClassification(_ bmiValue : Double) -> (bmiClassification:String,colorValue:UIColor){
      for i in 0..<bmiRange.count{
              if(bmiRange[i].contains(bmiValue)){
                  return (bmiClassification[i],bmiColorValue[i])
              }
          }
        return (bmiClassification:"",colorValue : .gray)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblResult.isHidden = true
    }

    
    @IBAction func txtHeightWeightEditingChanged(_ sender: Any) {
        //print((sender as! UITextField).placeholder!)
        lblResult.isHidden = true
    }
    
}

