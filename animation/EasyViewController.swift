import UIKit

final class EasyViewController: UIViewController {
    private let message = UILabel()
    private let textFiled = UITextField()
    private let button = UIButton()
    
    let model = EasyViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    private func setupUI() {

            view.backgroundColor = .white

            setupMessage()
            setupTextField()
            setupButton()

            addSubviews()
            makeConstraints()
        }

        private func addSubviews() {
            view.addSubview(message)
            view.addSubview(textFiled)
            view.addSubview(button)
        }
    
    private func setupBindings() {
        model.onMessageChanged = { [weak self] text in
            self?.message.text = text
        }
    }

    func makeConstraints() {
        message.translatesAutoresizingMaskIntoConstraints = false
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            message.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            message.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            message.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            textFiled.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            textFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textFiled.heightAnchor.constraint(equalToConstant: 60),
            textFiled.widthAnchor.constraint(equalToConstant: 250),

            button.leadingAnchor.constraint(equalTo: textFiled.trailingAnchor, constant: 12),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    func setupMessage() {
        message.textColor = .black
        message.font = .systemFont(ofSize: 36)
        message.textAlignment = .center
        message.numberOfLines = 0
    }

    func setupTextField() {
        textFiled.placeholder = "Напиши имя..."
        textFiled.layer.cornerRadius = 18
        textFiled.keyboardType = .default
        textFiled.layer.borderColor = UIColor.black.cgColor
        textFiled.layer.borderWidth = 4
        textFiled.backgroundColor = UIColor.clear
        textFiled.textAlignment = .center
    }

    func setupButton() {
        button.setTitle("Проверить", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 18
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleTapButton), for: .touchUpInside)
    }

    @objc
    func handleTapButton() {
        let name = textFiled.text ?? ""
        
        model.checkGender(name: name)
    }
}


//https://api.genderize.io/?name=Bob
//{
//  "name": "Alex",
//  "gender": "male",
//  "probability": 0.99,
//  "count": 100000
//}




