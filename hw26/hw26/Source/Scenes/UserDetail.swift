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
    
    let nameField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Print your name here"
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let icon = UIImageView(frame: CGRect(x: 15, y: 15, width: 30, height: 30))
        icon.image = UIImage(systemName: "person")
        icon.contentMode = .scaleAspectFit
        iconContainer.addSubview(icon)
        field.leftView = iconContainer
        field.leftViewMode = .always
        return field
    }()
    
    let birthdayField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Print your birthday here"
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let icon = UIImageView(frame: CGRect(x: 15, y: 15, width: 30, height: 30))
        icon.image = UIImage(systemName: "calendar")
        icon.contentMode = .scaleAspectFit
        iconContainer.addSubview(icon)
        field.leftView = iconContainer
        field.leftViewMode = .always
        return field
    }()
    
    let genderField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Print your gender here"
        field.isEnabled = false
        field.backgroundColor = .systemGray5
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let icon = UIImageView(frame: CGRect(x: 15, y: 15, width: 30, height: 30))
        icon.image = UIImage(systemName: "person.2")
        icon.contentMode = .scaleAspectFit
        iconContainer.addSubview(icon)
        field.leftView = iconContainer
        field.leftViewMode = .always
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        fillField(id: idUser)
    }
    
    func setupHierarchy() {
        view.addSubview(buttonClose)
        view.addSubview(buttonEditSave)
        view.addSubview(imageUser)
        view.addSubview(nameField)
        view.addSubview(birthdayField)
        view.addSubview(genderField)
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
        nameField.snp.makeConstraints { make in
            make.top.equalTo(imageUser.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        birthdayField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        genderField.snp.makeConstraints { make in
            make.top.equalTo(birthdayField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
    }
    
    @objc func editAndSaveMode() {
        if isEditingMode {
            guard let idUser = idUser else { return }
            if nameField.text == "" {
                //alert
                return
            }
            DataStoreManager().updateUser(
                id: idUser,
                name: nameField.text ?? "",
                birthday: birthdayField.text ?? "",
                gender: genderField.text ?? ""
            )
        }
        toggleMode()
    }
    
    var isEditingMode: Bool = false
    func toggleMode() {
        isEditingMode.toggle()
        buttonEditSave.setTitle(isEditingMode ? "Save" : "Edit", for: .normal)
        if isEditingMode {
            genderField.backgroundColor = .white
            genderField.isEnabled = true
        } else {
            genderField.backgroundColor = .systemGray5
            genderField.isEnabled = false
        }
    }
    
    @objc func close() {
        ViewController().tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func fillField(id: String?) {
        guard let user = DataStoreManager().getUsersById(id: id ?? "") else { return }
        nameField.text = user.name
        birthdayField.text = user.birthday?.convetrToString()
        genderField.text = user.gender
        
    }
}
