import UIKit

class UserDetail: UIViewController {
    public var idUser: String?
    var model: User?
    let gender = ["Choose gender","male","female"]
    var editButton: UIBarButtonItem?
    
    let imagePicker: UIImagePickerController = {
       let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        return picker
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    let genderPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let imageUser: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 100
        button.setImage(UIImage(named: "person"), for: .normal)
        button.addTarget(self, action: #selector(editImage), for: .touchUpInside)
        button.imageView?.layer.cornerRadius = 100
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.masksToBounds = true
        button.tintColor = .blue
        button.isUserInteractionEnabled = false
        return button
    }()
    
    let nameField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Print your name here"
        field.isEnabled = false
        field.backgroundColor = .systemGray6
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let icon = UIImageView(frame: CGRect(x: 15, y: 15, width: 30, height: 30))
        icon.image = UIImage(systemName: "person")
        icon.contentMode = .scaleAspectFit
        iconContainer.addSubview(icon)
        field.leftView = iconContainer
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
        return field
    }()
    
    let birthdayField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Print your birthday here"
        field.isEnabled = false
        field.backgroundColor = .systemGray6
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
        field.backgroundColor = .systemGray6
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
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAndSaveMode))
        navigationItem.rightBarButtonItem = editButton
        imagePicker.delegate = self
        createDatePicker()
        createGenderPicker()
    }
    
    func setupHierarchy() {
        view.addSubview(imageUser)
        view.addSubview(nameField)
        view.addSubview(birthdayField)
        view.addSubview(genderField)
    }

    func setupLayout() {
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
                let alert = UIAlertController(
                    title: "Предупреждение",
                    message: "Не указанно имя пользователя. Сохранение невозможно.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                return
            }
            DataStoreManager().updateUser(
                id: idUser,
                name: nameField.text ?? "",
                birthday: birthdayField.text ?? "",
                gender: genderField.text ?? "",
                image: imageUser.imageView?.image?.pngData()
            )
        }
        toggleMode()
    }
    
    var isEditingMode: Bool = false
    func toggleMode() {
        isEditingMode.toggle()
        editButton?.title = isEditingMode ? "Save" : "Edit"
        if isEditingMode {
            imageUser.isUserInteractionEnabled = true
            nameField.backgroundColor = .white
            nameField.isEnabled = true
            birthdayField.backgroundColor = .white
            birthdayField.isEnabled = true
            genderField.backgroundColor = .white
            genderField.isEnabled = true
        } else {
            imageUser.isUserInteractionEnabled = false
            nameField.backgroundColor = .systemGray6
            nameField.isEnabled = false
            birthdayField.backgroundColor = .systemGray6
            birthdayField.isEnabled = false
            genderField.backgroundColor = .systemGray6
            genderField.isEnabled = false
        }
    }
    
    func fillField(id: String?) {
        guard let user = DataStoreManager().getUsersById(id: id ?? "") else { return }
        nameField.text = user.name
        birthdayField.text = user.birthday?.convetrToString()
        genderField.text = user.gender
        if user.image == nil {
            imageUser.setImage(UIImage(named: "person"), for: .normal)
        } else {
            imageUser.setImage(UIImage(data: user.image ?? Data()), for: .normal)
        }
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(birthdayDonePressed))
        toolbar.setItems([doneButton], animated: true)
        birthdayField.inputAccessoryView = toolbar
        birthdayField.inputView = datePicker
        datePicker.date = birthdayField.text?.convertToDate() ?? Date.now
    }
    func createGenderPicker() {
        genderPicker.delegate = self
        genderPicker.dataSource = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(genderDonePressed))
        toolbar.setItems([doneButton], animated: true)
        genderField.inputAccessoryView = toolbar
        genderField.inputView = genderPicker
    }
    
   @objc func birthdayDonePressed() {
       birthdayField.text = datePicker.date.convetrToString()
       view.endEditing(true)
    }
    
    @objc func genderDonePressed() {
        view.endEditing(true)
        
    }
    
    @objc func editImage() {
        present(imagePicker, animated: true)
    }
}

extension UserDetail: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationController?.isToolbarHidden = false
        return true
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row != 0 {
            genderField.text = gender[row]
        }
    }
}

extension UserDetail: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true)
        DispatchQueue.main.async {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.imageUser.setImage(image, for: .normal)
        }
    }
}
