import UIKit

class UserDetailTableViewCell: UITableViewCell {

    static let identifier = "UserDetailTableViewCell"
    private let icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(icon)
        contentView.addSubview(textField)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func configure(with data: String?, image: String, mode: Bool) {
        if mode {
            contentView.backgroundColor = .white
            textField.backgroundColor = .white
        } else {
            contentView.backgroundColor = .systemGray5
            textField.backgroundColor = .systemGray5
        }
        textField.text = (data ?? "No name")
        icon.image = UIImage(systemName: image)
    }

}
