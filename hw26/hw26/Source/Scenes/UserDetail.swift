import UIKit

class UserDetail: UIViewController {
    public var idUser: String?
    var model: User?
    let gender = ["male","female"]
    
    let buttonClose: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    let buttonEditSave: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(editAndSaveMode), for: .touchUpInside)
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
        table.register(UserDetailTableViewCell.self, forCellReuseIdentifier: UserDetailTableViewCell.identifier)
        table.isUserInteractionEnabled = false
        table.backgroundColor = .systemGray5
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        model = DataStoreManager().getUsersById(id: idUser ?? "")
    }
    
    func setupHierarchy() {
        view.backgroundColor = .systemGray5
        view.addSubview(buttonClose)
        view.addSubview(buttonEditSave)
        view.addSubview(imageUser)
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
    }

    func setupLayout() {
        buttonClose.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
        }
        buttonEditSave.snp.makeConstraints { make in
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
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func editAndSaveMode() {
        
        if isEditingMode {
            guard let idUser = idUser else { return }
            DataStoreManager().updateUser(id: idUser, name: "us", birthday: "12/12/2000", gender: "ew")
        }
        toggleMode()
    }
    
    var isEditingMode: Bool = false
    func toggleMode() {
        isEditingMode.toggle()
        buttonEditSave.setTitle(isEditingMode ? "Save" : "Edit", for: .normal)
        table.isUserInteractionEnabled.toggle()
        if isEditingMode {
            table.backgroundColor = .white
            view.backgroundColor = .white
            table.reloadData()
        } else {
            table.backgroundColor = .systemGray5
            view.backgroundColor = .systemGray5
            table.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserDetailTableViewCell.identifier,
            for: indexPath
        ) as? UserDetailTableViewCell else {
            return UITableViewCell()
        }
        guard let user = model else { return cell }
        let data: String?
        let image: String
        switch indexPath.row {
        case 0:
            data = user.name
            image = "person"
        case 1:
            data = user.birthday?.convetrToString() ?? "-"
            image = "calendar"
        case 2:
            data = user.gender ?? "-"
            image = "person.2"
        default:
            data = "-"
            image = "photo"
        }
        cell.configure(with: data,image: image, mode: isEditingMode)
        return cell
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

extension UserDetail: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        gender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        gender[row]
    }
    
}
