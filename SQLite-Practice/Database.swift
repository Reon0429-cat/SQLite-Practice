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
    private var userDataStore: UserDataStore
    init() {
        let filePath = try! FileManager.default.url(for: .documentDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: false)
            .appendingPathComponent("sample.db").path
        db = try! Connection(filePath)
        userDataStore = UserDataStore(db: db)
    }
    
}

final class UserDataStore {
    
    private let table = Table("users")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let email = Expression<String>("email")
    private let db: Connection
    
    init(db: Connection) {
        self.db = db
        do {
            try db.run(table.create(block: { tableBuilder in
                tableBuilder.column(Expression<Int64>("id"), primaryKey: true)
                tableBuilder.column(Expression<String?>("name"))
                tableBuilder.column(Expression<String>("email"), unique: true)
            }))
        } catch {
            print("DEBUG_PRINT: ", error.localizedDescription)
        }
    }
    
}
