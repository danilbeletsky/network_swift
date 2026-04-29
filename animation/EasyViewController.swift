import UIKit

struct Person: Codable {
    let name: String
    let gender: String
}

final class EasyViewController: UIViewController {
    let message = UILabel()
    let textFiled = UITextField()
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessage()
        setupTextField()
        setupButton()
        setupUI()
        makeConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(message)
        view.addSubview(textFiled)
        view.addSubview(button)
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
        message.text = ""
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
        guard let name = textFiled.text, !name.isEmpty else {
            message.text = "Введите имя!"
            return
        }
        
        guard let url = URL(string: "https://api.genderize.io/?name=\(name)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                self?.message.text = "Данные не пришли!"
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(Person.self, from: data)
                DispatchQueue.main.async{
                    self?.message.text = "Имя - \(decoded.name)\nПол - \(decoded.gender)"
                }
            } catch {
                print("Ошибка декодирования \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


//https://api.genderize.io/?name=Bob
//{
//  "name": "Alex",
//  "gender": "male",
//  "probability": 0.99,
//  "count": 100000
//}
