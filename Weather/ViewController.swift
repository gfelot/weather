//
//  ViewController.swift
//  Weather
//
//  Created by Gil Felot on 01/12/15.
//  Copyright © 2015 Gil Felot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var labelField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getInfo(sender: AnyObject) {
        let baseURL = "http://www.weather-forecast.com/locations/"
        let endURL = "/forecasts/latest"
        let city = cityField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        let testURL = NSURL(string: baseURL + city + endURL)
        
        // With guard statement
        guard let url = testURL else {
            print("Test 1")
            self.labelField.text = "Couldn't find the weather for the city you are looking for - Please try again."
            return
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            guard let urlContent = data else {
                print("Test2")
                self.labelField.text = "Couldn't find the weather for the city you are looking for - Please try again."
                return
            }
            let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
            let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
            if websiteArray.count > 1 {
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    if weatherArray.count > 1 {
                        let weatherSummary = weatherArray[0]
                        // Don't forget to dispatch queue
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.labelField.text = weatherSummary.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        })
                    }
                }
                
            }
        task.resume()
        
        //        if let url = testURL {
        //            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
        //                if let urlContent = data {
        //                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
        //                    let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
        //                    if websiteArray.count > 1 {
        //                        let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
        //                        if weatherArray.count > 1 {
        //                            let weatherSummary = weatherArray[0]
        //                            flag = true
        //                            // Don't forget to dispatch queue
        //                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
        //                                self.labelField.text = weatherSummary.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
        //                            })
        //
        //                        }
        //                    }
        //                }
        //            }
        //            if flag == false {
        //                self.labelField.text = "Couldn't find the weather for the city you are looking for - Please try again."
        //            } else {
        //                task.resume()
        //            }
        //        } else {
        //            self.labelField.text = "Couldn't find the weather for the city you are looking for - Please try again."
        //        }
        //
    }
}

