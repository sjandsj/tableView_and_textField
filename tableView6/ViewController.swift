//
//  ViewController.swift
//  tableView6
//
//  Created by mac on 07/06/19.
//  Copyright © 2019 gammastack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var array = [["name":"Subhanshu", "location":"Jablapur"],["name":"Ritwik", "location":"Sagar"],["name":"Akshat", "location":"Dewas"],["name":"aman", "location":"Bhopal"],["name":"Ayush", "location":"Bhopal"]]
    var throughDataModels = [dataModel]()
    var indexValue:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendingToDataModel()
        configureReturnKey()
        //configureTapGesture()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func appendingToDataModel() {
        for i in 0...(array.count-1) {
            let dict = array[i]
            self.throughDataModels.append(dataModel(yourName: dict["name"] ?? "", yourCity: dict["location"] ?? ""))
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return throughDataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let model:dataModel = throughDataModels[indexPath.row]
        cell.nameLabel.text = model.name
        cell.cityLabel.text = model.city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updatingModel:dataModel = throughDataModels[indexPath.row]
        nameTextField.text = updatingModel.name
        cityTextField.text = updatingModel.city
        indexValue = indexPath.row
    }
    
    private func configureReturnKey() {
        nameTextField.delegate = self
        cityTextField.delegate = self
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func updateButton(_ sender: Any) {
        print(array[indexValue!])
        let dict = throughDataModels[indexValue!]
        dict.name = nameTextField.text!
        dict.city = cityTextField.text!
        self.tableView.reloadData()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        return true
    }
}

