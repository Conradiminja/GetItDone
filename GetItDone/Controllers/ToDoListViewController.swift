//
//  ViewController.swift
//  GetItDone
//
//  Created by Jesper Andersson on 21/1/18.
//  Copyright © 2018 Jesper Andersson. All rights reserved.
//
import UIKit
class ToDoListViewController: UITableViewController {

    var itemArray = [item]()
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "Train"
        itemArray.append(newItem)
        
        
        let newItem2 = item()
        newItem2.title = "Learn to code"
        itemArray.append(newItem2)
        
        
        let newItem3 = item()
        newItem3.title = "Do something productive.."
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        //ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true )
    }
    //MARK - Add new Items!
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()
        let alert = UIAlertController(title: "Add new task", message:"" , preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What happends when user clicks add item button from UIAlert
            
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        // the app reloads the view so the new text gets added
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Insert task here"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    

}

