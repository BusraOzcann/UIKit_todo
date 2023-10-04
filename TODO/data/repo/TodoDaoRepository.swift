//
//  TodoDaoRepository.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import Foundation
import RxSwift

class TodoDaoRepository{
    var todoList = BehaviorSubject<[Todo]>(value : [Todo]())
    
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todo.sqlite")
        db=FMDatabase(path: kopyalanacakYer.path)
    }
    
    
    func todoListele(){
        db?.open()
        var liste = [Todo]()
        do{
            let rs = try db!.executeQuery("SELECT * FROM todos", values: nil)
            
            while rs.next(){
                let todo_id = Int(rs.string(forColumn: "todo_id"))!
                let todo_name = rs.string(forColumn: "todo_name")!
                
                let todo = Todo(todo_id: todo_id, todo_name:todo_name)
                liste.append(todo)
            }
            
            todoList.onNext(liste)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    func kaydet(todo_name:String){
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO todos (todo_name) VALUES (?)", values: [todo_name])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func ara(aramaKelimesi:String){
        db?.open()
        var liste = [Todo]()
        do{
            let rs = try db!.executeQuery("SELECT * FROM todos WHERE todo_name like '%\(aramaKelimesi)%'", values: nil)
            
            while rs.next(){
                let todo_id = Int(rs.string(forColumn: "todo_id"))!
                let todo_name = rs.string(forColumn: "todo_name")!
                
                let todo = Todo(todo_id: todo_id, todo_name:todo_name)
                liste.append(todo)
            }
            
            todoList.onNext(liste)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    func guncelle(todo_id:Int, todo_name:String){
        db?.open()
        do{
            try db!.executeUpdate("UPDATE todos SET todo_name=? WHERE todo_id=?", values: [todo_name, todo_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func sil(todo_id:Int){
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM todos WHERE todo_id=?", values: [todo_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "todo", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todo.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{}
        }
    }
}
