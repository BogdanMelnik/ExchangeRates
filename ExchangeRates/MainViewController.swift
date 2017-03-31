//
//  MainViewController.swift
//  ExchangeRates
//
//  Created by Admin on 3/31/17.
//  Copyright © 2017 BMSoftware. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, XMLParserDelegate{
    
    private let url = "https://api.privatbank.ua/p24api/pubinfo?exchange&coursid=3"
    private var exchangerates: [Exchangerate] = []
    
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startParsing()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startParsing() {
        if !exchangerates.isEmpty{
            exchangerates = []
        }
        if let url = URL(string: url) {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                parser.parse()
            } else {
                print("Problems with parser init?")
            }
        } else {
            print("Problems with url init?")
        }
    }
    
    // MARK: XMLParserDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if (elementName == "exchangerate") {
            if let ccy = attributeDict["ccy"],
                let base_ccy = attributeDict["base_ccy"],
                let buy = attributeDict["buy"] ,
                let sale = attributeDict["sale"]
            {
                if let buy_d = Double.init(buy), let sale_d = Double.init(sale) {
                    exchangerates.append(Exchangerate(ccy: ccy, base_ccy: base_ccy , buy: buy_d, sale: sale_d))
                } else {
                    print("Problem with convertion to Double?")
                }
            } else {
                print("Problem with attributes?")
            }
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parsing error!")
        print("Error: \(parseError)")
        print("Error description: \(parseError.localizedDescription)")
    }
}
