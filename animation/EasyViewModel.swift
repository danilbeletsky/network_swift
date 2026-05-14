import Foundation

final class EasyViewModel {
    private let service: GenderServiceProtocol
    
    var onMessageChanged: ((String)->Void)?
    
    init(service: GenderServiceProtocol = GenserService()) {
        self.service = service
    }
    
    func checkGender(name: String) {
        guard !name.isEmpty else {
            onMessageChanged?("Введите имя!")
            return
        }
        
        service.fetchGender(name: name) { [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let person):
                    let text = """
                    Имя: \(person.name)
                    Пол: \(person.gender ?? "unknown")
                    """
                    self?.onMessageChanged?(text)
                case .failure(let failure):
                    self?.onMessageChanged?("Ошибка загрузки")
                }
            }
        }
    }
}
