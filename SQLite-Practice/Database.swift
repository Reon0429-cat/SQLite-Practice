//
//  Database.swift
//  SQLite-Practice
//
//  Created by 大西玲音 on 2021/11/10.
//

import Foundation
import SQLite

final class Database {
    
    private var db: Connection
    var userDataStore: UserDatastore
    
    init() {
        let filePath = try! FileManager.default.url(for: .documentDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: false)
            .appendingPathComponent("sample.db").path
        try? FileManager.default.removeItem(atPath: filePath)
        db = try! Connection(filePath)
        userDataStore = UserDatastore(db: db)
    }
    
}

final class UserDatastore {
    
    private let table = Table("users")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let email = Expression<String>("email")
    private let db: Connection
    
    init(db: Connection) {
        self.db = db
        do {
            try self.db.run(table.create { t in
                t.column(Expression<Int64>("id"), primaryKey: true)
                t.column(Expression<String>("name"))
                t.column(Expression<String>("email"), unique: true)
            })
            let migrationItems = [
                ["name": "REON", "email":"REON@mac.com"],
                ["name": "REON2", "email":"REON2@mac.com"]
            ]
            migrationItems.forEach { row in
                try? insert(name: row["name"]!, email: row["email"]!)
            }
        } catch {
            
        }
    }
    
    private func insert(name: String, email: String) throws {
        let insert = table.insert(self.name <- name, self.email <- email)
        try db.run(insert)
    }
    
    func find() -> [User] {
        let users = try! db.prepare(table).map {
            User(id: $0[id], name: $0[name], email: $0[email])
        }
        return users
    }
    
}

struct User {
    let id: Int64
    let name: String
    let email: String
    init(id: Int64, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}
