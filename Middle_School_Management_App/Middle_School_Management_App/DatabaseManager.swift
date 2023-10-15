//
//  DatabaseManager.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-09-30.
//

import Foundation
import RealmSwift
import CryptoSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    private let app: App
    private var user: User?
    private var realm: Realm?
    private let dbName = "Dev"
    
    init() {
        let realmAppID = "edyou-wtsxp"
        app = App(id: realmAppID)
    }
    
    enum SignUpError: Error {
        case passwordsDoNotMatch
    }
    
    // Sign up new users
    func signUp(email: String, password: String, confirmPassword: String, role: String, completion: @escaping (Result<User, Error>) -> Void) async throws{
        
        // check if passwords match
        guard password == confirmPassword else {
            print("passwords do not match")
            return
        }
        
        let client = app.emailPasswordAuth
        
        // register user
        do {
            try await client.registerUser(email: email, password: password)
            print("successfully registered user")
            
            app.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
                switch result {
                case .success (let user):
                    // add user to db
                    let client = user.mongoClient("mongodb-atlas")
                    let database = client.database(named: "Dev")
                    let collection = database.collection(withName: "users")
                    
                    if (role == "TEACHER") {
                        collection.insertOne([
                            "userID": AnyBSON(user.id),
                            "role": "teacher"
                        ]) { (result) in
                            switch result {
                            case .failure(let error):
                                print("Failed to insert document: \(error.localizedDescription)")
                            case .success(let newObjId):
                                print("Inserted custom user data document with object ID: \(newObjId)")
                            }
                        }
                    } else if (role == "STUDENT") {
                        collection.insertOne([
                            "userID": AnyBSON(user.id),
                            "role": "student"
                        ]) { (result) in
                            switch result {
                            case .failure(let error):
                                print("Failed to insert document: \(error.localizedDescription)")
                            case .success(let newObjId):
                                print("Inserted custom user data document with object ID: \(newObjId)")
                            }
                        }
                    }
                    
                case .failure(let error):
                    // error message if failed to log in
                    print("Failed to log in: \(error.localizedDescription)")
                }
            }
        } catch {
            // error message if failed to register user
            print("failed to register: \(error.localizedDescription)")
        }
        
    }
    
    // Log in existing user
    func loginUser(email: String, password: String) async throws -> User {
        // user authentication
        let creds = Credentials.emailPassword(email: email, password: password)
        do {
            let user = try await app.login(credentials: creds)
            // set user property to the authenticated user
            self.user = user
            // return authenticated user
            return user
        } catch {
            throw error
        }
    }
    
    // Connect to Realm with authenticated user
    func openRealm() -> Realm? {
        // make sure user is authenticated first
        guard let user = self.user else {
            return nil
        }
        
        // Configure Realm for authenticated user
        let realmConfig = user.configuration(partitionValue: user.id)
        
        do {
            self.realm = try Realm(configuration: realmConfig)
            return self.realm
        } catch {
            print("Failed to open Realm: \(error.localizedDescription)")
            return nil
        }
    }
    
    // delete user from db
    func deleteUser(user: User) {
        // TODO
    }
}
