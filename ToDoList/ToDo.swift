//
//  ToDo.swift
//  Productivaaa 7.0
//
//  Created by Elaine Hsu on 3/13/20.
//  Copyright © 2020 Elaine Hsu. All rights reserved.
//

import Foundation

struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        return [
            ToDo(title: "Feed the fish", isComplete: false, dueDate: Date(), notes: "pour food into aquarium"),
            ToDo(title: "Finish DD report", isComplete: false, dueDate: Date(), notes: "submit crit B on ManageBac by 9 p.m."),
            ToDo(title: "Buy a cake for Dad's birthday", isComplete: false, dueDate: Date(), notes: "chocolate")
        ]
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        ((try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)) as ()??)
    }
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
