//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kevin Morris on 11/19/19.
//  Copyright © 2019 Kevin Morris. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        
        cell.textLabel?.text = category.name
        
        
        return cell
        
    }
    
    
    //MARK: - Tableview data manipulation methods
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on our UIAlert
            
            if textField.text != "" {
                
                
                
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                
                self.categoryArray.append(newCategory)
                
                self.saveCategories()
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving category context \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching category data from context, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Table view Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToItems", sender: self )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
