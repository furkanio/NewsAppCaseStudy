//
//  DAL.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 29.03.2022.
//

import Foundation
import CoreData
import UIKit

class DAL {
    static func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    static func saveData(title: String, author: String, newsdate: String, explain: String, newsimage: String, setfavorite: Bool, weburl: String) {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "New", in: context)
        
        let data = NSManagedObject(entity: entity!, insertInto: context)
        
        data.setValue(title, forKey: "title")
        data.setValue(author, forKey: "author")
        data.setValue(newsdate, forKey: "newsDate")
        data.setValue(explain, forKey: "newsDescription")
        data.setValue(newsimage, forKey: "newsImage")
        data.setValue(setfavorite, forKey: "setFavoriteBool")
        data.setValue(weburl, forKey: "webUrl")
        

        do{
            try context.save()
        } catch {}
        
    }
    
    static func getAllData() -> [New]? {
        
        let fetchRequest : NSFetchRequest<New> = New.fetchRequest()
        
        do {
            return try getContext().fetch(fetchRequest)
        } catch {
            
        }
        return nil
        
    }
    
    static func update() {
        
        try? getContext().save()
    }
    
    static func deleteFunc(data: New){
        
        getContext().delete(data)
        
        try? getContext().save()
    }
    
}
