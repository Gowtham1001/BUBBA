//
//  ChatManager.swift
//  Bubba
//
//  Created by Shrreya Ram on 23/04/23.
//

import Foundation

protocol ChatManagerDelegate {
    func didUpdateChat(_ chatManager: ChatManager, chat: String)
    func didFailWithError(error: Error)
}

struct ChatManager {
    
    var delegate: ChatManagerDelegate?
    func fetchChat(chat: String) {

        let urlString = "https://02a1-34-173-104-25.ngrok-free.app/chat/" //Change API ID based on your Colab public URL
        performRequest(with: urlString, chat:chat)
    }
    
    
    func performRequest(with urlString: String, chat:String) {
        
        
        let payload = ["input_text":chat]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload, options: [])
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data {
                let str = String(data: data, encoding: .utf8)!
                self.delegate?.didUpdateChat(self,chat: String(str.dropFirst().dropLast()))
            }
        }
        task.resume()
    }
    
    
    
}

