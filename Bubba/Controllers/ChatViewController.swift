//
//  ChatViewController.swift
//  Bubba
//
//  Created by Shrreya Ram on 21/04/23.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var chatManager = ChatManager()
    private var messages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: searchTextField.frame.size.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always

        
        chatManager.delegate = self
        searchTextField.delegate = self
        tableView.dataSource = self
        
        
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        let nib2 = UINib(nibName: "EvenTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "EvenTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToBottom()
    }


}

//MARK: - UITextFieldDelegate

extension ChatViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let chat = searchTextField.text {
            chatManager.fetchChat(chat: chat)
            messages.append(searchTextField.text!)
            tableView.reloadData()
            scrollToBottom()
        }
        
        searchTextField.text = ""
        
    }
    private func scrollToBottom() {
        if messages.count > 0 {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    func addChat(chat : String){
        messages.append(chat)
        tableView.reloadData()
        scrollToBottom()
    }
}

//MARK: - ChatManagerDelegate


extension ChatViewController: ChatManagerDelegate{
    
    func didUpdateChat(_ chatManager: ChatManager, chat: String) {
        DispatchQueue.main.async {

            self.addChat(chat: chat)

        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EvenTableViewCell", for: indexPath) as! EvenTableViewCell
                cell.label2.text = messages[indexPath.row]
                cell.backgroundColor = UIColor.clear
                return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.label1.text = messages[indexPath.row]
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EvenTableViewCell") as! EvenTableViewCell
            cell.label2.text = messages[indexPath.row]
            cell.label2.sizeToFit()
            cell.backgroundColor = UIColor.clear
            return cell.label2.frame.height// add some padding
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
            cell.label1.text = messages[indexPath.row]
            if cell.label1.frame.height == 0 {
                cell.label1.sizeToFit()
            }
            cell.backgroundColor = UIColor.clear
            return cell.label1.frame.height // add some padding
        }
    }

}
