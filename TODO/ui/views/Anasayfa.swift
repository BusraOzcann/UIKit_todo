//
//  ViewController.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import UIKit

class Anasayfa: UIViewController {
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todoList = [Todo]()
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        todoTableView.delegate = self
        todoTableView.dataSource = self
        _ = viewModel.todoList.subscribe(onNext: { liste in
            self.todoList = liste
            self.todoTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.listele()
    }
    
    @IBAction func ekleBtn(_ sender: Any) {
        performSegue(withIdentifier: "toEkle", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let todo = sender as? Todo {
                let gidilecekVC = segue.destination as! Detay
                gidilecekVC.todo = todo
            }
        }
    }
    
}

extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi: searchText)
    }
}


extension Anasayfa: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count//3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//0,1,2
        let hucre = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
        
        let todo = todoList[indexPath.row]
        
        hucre.labelName.text = todo.todo_name
        
        return hucre
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: todo)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    */
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ contextualAction,view,bool in
            let todo = self.todoList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(todo.todo_name!) silinsi mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sil(todo_id: todo.todo_id!)
                self.viewModel.listele()
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle"){ contextualAction,view,bool in
            let todo = self.todoList[indexPath.row]
            
            self.performSegue(withIdentifier: "toDetay", sender: todo)
        }
        guncelleAction.backgroundColor = UIColor.orange
        
        return UISwipeActionsConfiguration(actions: [silAction, guncelleAction])
    }
}
