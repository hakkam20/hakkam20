//
//  ViewController.swift
//  HarminderMobileDevTest
//
//  Created by Singh, Harminder (external - Project) on 29/01/20.
//  Copyright © 2020 Singh, Harminder. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import Foundation
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var CompanyTableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var SortButton: UIButton!
    
    let cellReuseIdentifier = "ComapanyTableViewCell"
    var dictionary = NSDictionary()
    var CompaniesArray = NSArray()
    var SortedArray = NSArray()
    var FilteredCompaniesArray = NSArray()
    var searchActive = Bool()
    var Sort = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CompanyTableView.delegate = self
        CompanyTableView.dataSource = self
        SearchBar.delegate = self
        parseJSON()
        
        // Do any additional setup after loading the view.
    }
    
    
    func parseJSON() {
        if let path = Bundle.main.path(forResource: "document", ofType: "json")
        {
            print(path)
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                dictionary = jsonResult as! NSDictionary
                CompaniesArray = dictionary["Companies"] as! NSArray
                
                let nameDiscriptor = NSSortDescriptor(key: "CompanyName", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

                CompaniesArray = (CompaniesArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
                SortButton.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
                Sort = "Descending"
                
                SortButton.layer.borderWidth = 1
                SortButton.layer.masksToBounds = false
                SortButton.layer.borderColor = UIColor.white.cgColor
                SortButton.layer.backgroundColor = UIColor.yellow.cgColor
                SortButton.layer.cornerRadius = SortButton.frame.height/2
                SortButton.layer.shadowColor = UIColor.black.cgColor
                SortButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                SortButton.layer.shadowRadius = 1.0
                SortButton.layer.shadowOpacity = 0.5
                SortButton.clipsToBounds = true
                
                print(CompaniesArray)
                
            } catch {
                // handle error
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String)
    {
        print("searchText \(searchText)")
        CompaniesArray = dictionary["Companies"] as! NSArray
        
        if searchText != ""
        {
            let searchPredicate = NSPredicate(format: "CompanyName CONTAINS[C] %@", searchText)
            CompaniesArray = (CompaniesArray as NSArray).filtered(using: searchPredicate) as NSArray
        }
        else{
          CompaniesArray = dictionary["Companies"] as! NSArray
            let nameDiscriptor = NSSortDescriptor(key: "CompanyName", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

            CompaniesArray = (CompaniesArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
            SortButton.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
            Sort = "Descending"
        }
        self.CompanyTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        SearchBar.resignFirstResponder()
        self.SearchBar.endEditing(true)
        self.CompanyTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        CompaniesArray = dictionary["Companies"] as! NSArray
        let nameDiscriptor = NSSortDescriptor(key: "CompanyName", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

        CompaniesArray = (CompaniesArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
        SortButton.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
        Sort = "Descending"
        SearchBar.text = ""
        SearchBar.resignFirstResponder()
        self.SearchBar.endEditing(true)
        //searchActive = false
        self.CompanyTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return CompaniesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: ComapanyTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? ComapanyTableViewCell

          if cell == nil
          {
            tableView.register(UINib(nibName: "ComapanyTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
            cell = CompanyTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? ComapanyTableViewCell
            }
        
        cell.btn_Favourite.tag = indexPath.row
        cell.btn_Favourite.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        //btn_Follow
    
        cell.CompanyName.text = ((CompaniesArray[indexPath.row]as? [String: Any])?["CompanyName"]) as? String
        cell.CompanyWebsite.text = ((CompaniesArray[indexPath.row]as? [String: Any])?["website"]) as? String
        cell.CompanyDescription.text = ((CompaniesArray[indexPath.row]as? [String: Any])?["Description"]) as? String
    
        cell.CompanyImage.layer.borderWidth = 1
        cell.CompanyImage.layer.masksToBounds = false
        cell.CompanyImage.layer.borderColor = UIColor.white.cgColor
        cell.CompanyImage.layer.cornerRadius = cell.CompanyImage.frame.height/2
        cell.CompanyImage.clipsToBounds = true
        
        cell.btn_Follow.layer.borderWidth = 1
        cell.btn_Follow.layer.masksToBounds = false
        cell.btn_Follow.layer.borderColor = UIColor.white.cgColor
        cell.btn_Follow.layer.cornerRadius = 10
        cell.btn_Follow.clipsToBounds = true
    
        cell.CompanyImage.sd_setImage(with: URL(string: ((CompaniesArray[indexPath.row]as? [String: Any])?["logo"] as! String)), placeholderImage: UIImage(named: "Company"))
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "MemberSegue", sender: indexPath)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let indexPath = sender as! IndexPath
        if segue.identifier == "MemberSegue" {
            if let DVC = segue.destination as? MemberViewController
            {
                DVC.MembersArray = ((CompaniesArray[indexPath.row]as? [String: Any])?["MembersArray"]) as! NSArray
            }
            else {
                print("Data NOT Passed! destination vc is not set to firstVC")
            }
        } else { print("Id doesnt match with Storyboard segue Id") }
   
        
    }
    
    @IBAction func SortButton(_ sender: Any)
    {
        if Sort.isEqual(to: "Ascending")
        {
            let nameDiscriptor = NSSortDescriptor(key: "CompanyName", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

            CompaniesArray = (CompaniesArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
            SortButton.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
            Sort = "Descending"
        }
        else
        {
            let nameDiscriptor = NSSortDescriptor(key: "CompanyName", ascending: false, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            
            CompaniesArray = (CompaniesArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray

            SortButton.setImage(UIImage(named: "A-Z")!, for: UIControl.State.normal)
            Sort = "Ascending"
        }
        
        CompanyTableView.reloadData()
    }
    
    @objc func buttonSelected(sender: UIButton)
    {
        print(sender.tag)
        
        var json = JSON(dictionary)
        
        json["Companies"][sender.tag]["Favourite"].stringValue = "1"
          
        print(json)
        
       if let path = Bundle.main.path(forResource: "document", ofType: "json")
        {
            print(path)
            do {
                   let encoder = JSONEncoder()
                   encoder.outputFormatting = .prettyPrinted
                   let JsonData = try encoder.encode(json)
                try JsonData.write(to: URL(fileURLWithPath: path))
               }catch{}
           }
           
    }
    
    
       
    
}

