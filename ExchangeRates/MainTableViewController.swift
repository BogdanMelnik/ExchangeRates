//
//  MainTableViewController.swift
//  ExchangeRates
//
//  Created by Admin on 3/31/17.
//  Copyright © 2017 BMSoftware. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, XMLParserDelegate{
    
    private let url = "https://api.privatbank.ua/p24api/pubinfo?exchange&coursid=3"
    private var exchangerates: [Exchangerate] = []
    
    let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
    
    // MARK: Outlets
    
    
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(nib, forCellReuseIdentifier: "MainCell")
        
        tableView.tableFooterView = UIView()
        
        startParsing()
        ()
        
    }
    
    func getCurrentDate () -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
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
    
    // MARK: TableView Delegate methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        
        if (!exchangerates.isEmpty) && (exchangerates.count == 3) {
            switch indexPath.row {
            case 0:
                cell.configureCellUI(exchangerate: exchangerates[0])
            case 1:
                cell.configureCellUI(exchangerate: exchangerates[1])
            case 2:
                cell.configureCellUI(exchangerate: exchangerates[2])
            default: break
            }
        }
        
        return cell
    }

}
