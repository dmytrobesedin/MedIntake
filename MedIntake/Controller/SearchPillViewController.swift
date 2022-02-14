//
//  SearchPillViewController.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 25.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//
import Firebase
import UIKit

class SearchPillViewController: UIViewController {
    
    
    
    
    
    
   private  var tableview =  UITableView()
   private  var searchBar =  UISearchBar()
    
    
    
    private var data = [Test]()
        
        
        
/*["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"] */
    
    
   //[Pill]()
    
    
  private   var filteredData: [Test]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        filteredData = data

        
        
        //searchBar = UISearchBar() // UISearchController(searchResultsController: nil)
        searchBar.delegate = self
        searchBar.searchBarStyle  = .default
        
        searchBar.placeholder = "Search"
        
        
        // searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        searchBar.sizeToFit()
        
        //   searchBar. = false
        
        
        // set tableview up
        tableview = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        view.addSubview(tableview)
        tableview.tableHeaderView = searchBar
        
        
        
        tableview.delegate = self
        tableview.dataSource = self
        
        
        
        definesPresentationContext = true
        //
        
        
        loadDataFromFirebase()
        
        
        
        //   addSearchButton()
        
        
        // Do any additional setup after loading the view.
        
        
    }
//   private func addSearchButton()  {
//        var searchButton = UISearchBar()
//
//
//        //searchButton = UISearchBar(frame: CGRect(x: 10, y: 10, width: view.frame.width - 20, height: view.frame.height - 20))
//        searchButton.searchBarStyle  = .default
//        // searchButton.placeholder = "Search..."
//        searchButton.sizeToFit()
//
//        searchButton.backgroundImage = UIImage()
//        searchButton.isTranslucent = false
//
//        // navigationItem.titleView = searchButton
//        //  tableview.tableHeaderView = searchButton
//        view.addSubview(searchButton)
//    }
//
//    func addTableView() {
//
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
//
//
//    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//                                                                    return dataString.range(of: searchText, options: .caseInsensitive)  != nil})
//
//            tableview.reloadData()
//        }
//    }
//\
    
    
    // completion handler!!!! возвращает дата или ошибка
  private  func loadDataFromFirebase() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let ref = Database.database().reference(withPath: "pills")
        
        
        
        ref.observeSingleEvent(of: .value) { snapshot in
            
                
//            firebaseService.loadPill(id: String) { Pill?, Error? in
//
//            }
        
            var newPillsArray = [Test]()
            
            
            for children in snapshot.children{
                guard let dataSnapshot = children as? DataSnapshot else {  return}
                
                
            let testArray = Test(dataSnapshot)
                newPillsArray.append(testArray)
            }
            
            
             self.data = newPillsArray
            self.filteredData = self.data
            self.tableview.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        } withCancel: { error in
            let alertPresenter = AlertPresenter()
            alertPresenter.showAlert(title: "Error", message: error.localizedDescription, viewController:self )
        }

    
    }
}
//    func comleteAction(at indexPath: IndexPath, tableView: UITableView) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "isChecked") { (action, view, completion) in
//            guard let cell = tableView.cellForRow(at: indexPath) else {return}
//            var pillsList = self.data[indexPath.row]
//
//            // let switchToggle = pillsList.isChecked
//                let toggle = !switchToggle
//                let viewControllerHelper = ViewControllerHelper()
//                viewControllerHelper.cellCheckbox(cell: cell, isIntake: toggle)
//
//              //  pillsList.isChecked = toggle
//
//                self.data[indexPath.row] = pillsList
//
//
//                //pillsList.ref.updateChildValues(["isChecked": toggle])
//                tableView.reloadData()
//
//            completion(true)
//        }
//
//
//        let pillsList = self.data[indexPath.row]
//      //  let switchToggle = pillsList.
//        let switchToggle = false
//        action.image = UIImage(named:"Check")
//        if switchToggle == false{
//            action.backgroundColor = .green
//            return action
//        }
//        else{
//            action.backgroundColor = .red
//            return action
//        }
//
//    }
//

    extension SearchPillViewController: UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableview.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
            let pillsArray = filteredData[indexPath.row]
            cell.textLabel?.text = pillsArray.city
         
                let viewControllerHelper = ViewControllerHelper()
            viewControllerHelper.cellCheckbox(cell: cell, isIntake: pillsArray.boolTest)
        
            return cell
            
            
            }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        
        // MARK: SearchBar Configure
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if let searchText = searchBar.text {
                filteredData = searchText.isEmpty ? data : data.filter({ (dataPill: Test) -> Bool in
                                                                        return  dataPill.city?.range(of: searchText, options: .caseInsensitive)  != nil})
                
                tableview.reloadData()
            }
        }
        
//        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//            let complete = comleteAction(at: indexPath, tableView: tableView)
//            return UISwipeActionsConfiguration(actions: [complete])
//        }
//
    }


