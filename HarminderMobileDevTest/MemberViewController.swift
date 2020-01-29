//
//  MemberViewController.swift
//  HarminderMobileDevTest
//
//  Created by Singh, Harminder (external - Project) on 29/01/20.
//  Copyright © 2020 Singh, Harminder. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var MemberTableView: UITableView!
    @IBOutlet weak var btn_Sort: UIButton!
    @IBOutlet weak var Age_Sort: UIButton!
    var MembersArray = NSArray()
    var InitialMembersArray = NSArray()
    
    let cellReuseIdentifier = "MemberTableViewCell"
    
    var Sort = NSString()
    var AgeSort = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_Sort.layer.borderWidth = 1
        btn_Sort.layer.masksToBounds = false
        btn_Sort.layer.borderColor = UIColor.white.cgColor
        btn_Sort.layer.backgroundColor = UIColor.yellow.cgColor
        btn_Sort.layer.cornerRadius = btn_Sort.frame.height/2
        btn_Sort.layer.shadowColor = UIColor.black.cgColor
        btn_Sort.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btn_Sort.layer.shadowRadius = 1.0
        btn_Sort.layer.shadowOpacity = 0.5
        btn_Sort.clipsToBounds = true
        
        Age_Sort.layer.borderWidth = 1
        Age_Sort.layer.masksToBounds = false
        Age_Sort.layer.borderColor = UIColor.white.cgColor
        Age_Sort.layer.backgroundColor = UIColor.yellow.cgColor
        Age_Sort.layer.cornerRadius = Age_Sort.frame.height/2
        Age_Sort.layer.shadowColor = UIColor.black.cgColor
        Age_Sort.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        Age_Sort.layer.shadowRadius = 1.0
        Age_Sort.layer.shadowOpacity = 0.5
        Age_Sort.clipsToBounds = true
        
        InitialMembersArray = MembersArray
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        
        MemberTableView.delegate = self
        MemberTableView.dataSource = self
        SearchBar.delegate = self
        
        let nameDiscriptor = NSSortDescriptor(key: "Name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        
        MembersArray = (MembersArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
        btn_Sort.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
        Age_Sort.setImage(UIImage(named: "2-1")!, for: UIControl.State.normal)
        Sort = "Descending"
        AgeSort = "Descending"

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String)
    {
        print("searchText \(searchText)")
        MembersArray = InitialMembersArray
        
        if searchText != ""
        {
            let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
            MembersArray = (MembersArray as NSArray).filtered(using: searchPredicate) as NSArray
        }
        else{
          MembersArray = InitialMembersArray
            let nameDiscriptor = NSSortDescriptor(key: "Name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

            MembersArray = (MembersArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
            btn_Sort.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
            Age_Sort.setImage(UIImage(named: "2-1")!, for: UIControl.State.normal)
            Sort = "Descending"
            AgeSort = "Descending"
        }
        self.MemberTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        SearchBar.resignFirstResponder()
        self.SearchBar.endEditing(true)
        self.MemberTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        MembersArray = InitialMembersArray
        let nameDiscriptor = NSSortDescriptor(key: "Name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

        MembersArray = (MembersArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
        btn_Sort.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
        Age_Sort.setImage(UIImage(named: "2-1")!, for: UIControl.State.normal)
        Sort = "Descending"
        SearchBar.text = ""
        SearchBar.resignFirstResponder()
        self.SearchBar.endEditing(true)
        //searchActive = false
        self.MemberTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return MembersArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: MemberTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MemberTableViewCell

          if cell == nil
          {
            tableView.register(UINib(nibName: "MemberTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
            cell = MemberTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MemberTableViewCell
            }
        
        cell.MemberName.text = (MembersArray[indexPath.row]as? [String: Any])?["Name"] as? String
        cell.MemberAge.text = (MembersArray[indexPath.row]as? [String: Any])?["Age"] as? String
        cell.MemberPhone.text = (MembersArray[indexPath.row]as? [String: Any])?["Phone"] as? String
        cell.MemberEmail.text = (MembersArray[indexPath.row]as? [String: Any])?["email"] as? String

        
        return cell
        
    }
    
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }

    @IBAction func SortButton(_ sender: Any)
    {
        if Sort.isEqual(to: "Ascending")
        {
            let nameDiscriptor = NSSortDescriptor(key: "Name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

            MembersArray = (MembersArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
            btn_Sort.setImage(UIImage(named: "Z-A")!, for: UIControl.State.normal)
            Sort = "Descending"
        }
        else
        {
            let nameDiscriptor = NSSortDescriptor(key: "Name", ascending: false, selector: #selector(NSString.caseInsensitiveCompare(_:)))

            MembersArray = (MembersArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
            btn_Sort.setImage(UIImage(named: "A-Z")!, for: UIControl.State.normal)
            Sort = "Ascending"
        }

        MemberTableView.reloadData()
    }
    
    @IBAction func Age_Sort(_ sender: Any) {
        if AgeSort.isEqual(to: "Ascending")
        {
            let nameDiscriptor = NSSortDescriptor(key: "Age", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

            MembersArray = (MembersArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
            Age_Sort.setImage(UIImage(named: "2-1")!, for: UIControl.State.normal)
            AgeSort = "Descending"
        }
        else
        {
            let nameDiscriptor = NSSortDescriptor(key: "Age", ascending: false, selector: #selector(NSString.caseInsensitiveCompare(_:)))

            MembersArray = (MembersArray as NSArray).sortedArray(using: [nameDiscriptor]) as NSArray
            Age_Sort.setImage(UIImage(named: "1-2")!, for: UIControl.State.normal)
            AgeSort = "Ascending"
        }

        MemberTableView.reloadData()
    }
    
    
    @objc func buttonSelected(sender: UIButton){
        print(sender.tag)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
