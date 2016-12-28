//
//  CountryListViewController.swift
//  Driver
//
//  Created by Tien Dat on 11/8/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import UIKit
import PhoneNumberKit

class CountryCell: UITableViewCell {
    @IBOutlet var lbFlag: UILabel!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbPhoneCode: UILabel!
    
}
class CountryListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTxt: UISearchBar!
    
    
    var listAllCountryCode: [String]!
    var selectionData: (countryCode: String, countryName: String, phone: String)?
    var countrySectionList: [String] {
        var result = [String]()
        //add new header to result
        for country in countrieSorted {
            let section = String(country.characters.first!)
            if !result.contains(section) {
                result.append(section)
            }
        }
        //sort section in alpha list
        result.sort { (left, right) -> Bool in
            left < right
        }
        return result
    }
    var countrieSorted = [String]()
    var countries: [String]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchTxt.delegate = self
        
        
        listAllCountryCode = PhoneKit.shareInstance.listCountryCode
        //init list countries and sort in alpha list
        countries = Array(PhoneKit.shareInstance.countryName.values)
        countries = countries.sorted { $0 < $1 }
        
        countrieSorted = countries
        sortCountryList(searchText: "")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sortCountryList(searchText: String){
        if searchText == ""  { countrieSorted = countries }
        else {
            countrieSorted = countries.filter { element in
                element.uppercased().contains(searchText.uppercased())
            }
        }
        tableView.reloadData()
    }
    
    func countryCode(countryName: String) -> String {
        let code = PhoneKit.shareInstance.countryName.filter { (_, value) in
            return value == countryName
            }.first!.key
        return code
    }
    
    
    
    
    func dismissCountryList(){
        
    }

}

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func countryInSection(index: Int) -> [String] {
        var result = [String]()
        let section = countrySectionList[index]
        result = countrieSorted.filter { (country) -> Bool in
            String(country.characters.first!) == section
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let section = indexPath.section
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell {
            let phoneKit = PhoneKit.shareInstance
            
            let countryName = countryInSection(index: section)[index]
            
            let code = countryCode(countryName: countryName)
            let flag = code.flag()
            let phoneCode = phoneKit.phoneCode[code]
            
            
            cell.lbFlag.text = flag
            cell.lbName.text = countryName
            cell.lbPhoneCode.text = phoneCode
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countrySectionList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryInSection(index: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countrySectionList[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CountryCell else { return }
        guard let countryName = cell.lbName.text else { return }
        let code = countryCode(countryName: countryName)
        
        
        selectionData = PhoneKit.shareInstance.countryData(countryCode: code)
        print("Selection Data: \(selectionData)")
        
        _ = navigationController?.popViewController(animated: true)
        
        //dismiss(animated: true, completion: nil)
    }
    
    
}

extension CountryListViewController:UISearchBarDelegate{
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortCountryList(searchText: searchText)
    }
}
