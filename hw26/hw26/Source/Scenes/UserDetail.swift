import UIKit

class UserDetail: UIViewController {
    
    let buttonClose: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    let buttonEdit: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Edit", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    let imageUser: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray6
        image.layer.cornerRadius = 100
        return image
    }()
    
    let table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        return table
    }()
    
    var dataStoreManager = DataStoreManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        
        let users = dataStoreManager.obtainMainUser()
        print(users.name)
        print(users.birthday)
        
    }
    
    func setupHierarchy() {
        view.addSubview(buttonClose)
        view.addSubview(buttonEdit)
        view.addSubview(imageUser)
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
    }

    func setupLayout() {
        buttonClose.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
        }
        buttonEdit.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(70)
        }
        imageUser.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.height.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        table.snp.makeConstraints { make in
            make.top.equalTo(imageUser.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserDetail: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

extension UserDetail: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
}
