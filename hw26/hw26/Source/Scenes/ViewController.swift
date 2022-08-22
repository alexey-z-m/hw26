import UIKit
import SnapKit

class ViewController: UIViewController {

    var countOfRows = 5
    let labelUsers: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        label.text = "Users"
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Print your name here"
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Press", for: .normal)
        button.setTitleColor( .white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupHierarchy() {
        view.addSubview(labelUsers)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        labelUsers.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(labelUsers.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        present(UserDetail(), animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countOfRows
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            countOfRows -= 1
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
