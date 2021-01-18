 import UIKit
 
 enum CarBrand {
    case Hyundai, Mazda, Geely, Mersedes, Volvo
 }
 
 enum CarTransmission {
    case full, front, back;
 }
 
 extension CarTransmission : CustomStringConvertible {
    
    var description: String {
        switch self {
        case .back:
            return "Задний привод"
        case .front:
            return "Передний привод"
        case .full:
            return "Полный привод"
        }
    }
 }
 
 protocol Car : class {
    var brand: CarBrand { get }
    var year: UInt16 { get }
    var trunkVolume: UInt16 { get }
    var isEngineStarted: Bool { get set }
    var isWindowsOpened: Bool { get set }
    
    func engine(status: Bool) -> Bool
    func windows(status: Bool) -> Bool
 }
 
 extension Car {
    
    func engine(status: Bool) -> Bool {
        if status != isEngineStarted {
            isEngineStarted = status
            return true
        } else {
            return false
        }
    }
    
    func windows(status: Bool) -> Bool {
        if status != isWindowsOpened {
            isWindowsOpened = status
            return true
        } else {
            return false
        }
    }
 }
 
 class SportCar : Car {
    let brand: CarBrand
    let year: UInt16
    let trunkVolume: UInt16
    let transmission: CarTransmission
    var isEngineStarted: Bool = false
    var isWindowsOpened: Bool = false
    var isManholeOpened: Bool = false
    
    init(brand: CarBrand, year: UInt16, trunkVolume: UInt16, transmission: CarTransmission) {
        self.brand = brand
        self.year = year
        self.trunkVolume = trunkVolume
        self.transmission = transmission
    }
    
    func manhole(status: Bool) -> Bool {
        if status != isManholeOpened {
            isManholeOpened = status
            return true
        } else {
            return false
        }
    }
 }
 
 extension SportCar: CustomStringConvertible {
    var description: String {
        return """
            Легковой автомобиль
            Модель: \(brand)
            Год выпуска: \(year)
            Объем багажника: \(trunkVolume)
            Трансмиссия: \(transmission)
            Состояние двигателя: \(isEngineStarted ? "Запущен" : "Остановлен"), \
            Состояние окон: \(isWindowsOpened ? "Открыты" : "Закрыты"), \
            Состояние люка: \(isManholeOpened ? "Открыт" : "Закрыт")

            """
    }
 }
 
 var geelyEmgrandGT = SportCar(brand: .Geely, year: 2016, trunkVolume: 500, transmission: .front)
 geelyEmgrandGT.engine(status: true)
 geelyEmgrandGT.manhole(status: true)
 print(geelyEmgrandGT)

 
 class TrunkCar: Car {
    let brand: CarBrand
    let year: UInt16
    let trunkVolume: UInt16
    let haveTrailer: Bool
    var isEngineStarted: Bool = false
    var isWindowsOpened: Bool = false
    var isCarBodyUp: Bool = false
    
    init(brand: CarBrand, year: UInt16, trunkVolume: UInt16, haveTrailer: Bool) {
        self.brand = brand
        self.year = year
        self.trunkVolume = trunkVolume
        self.haveTrailer = haveTrailer
    }
    
    func carBody(status: Bool) -> Bool {
        if status != isCarBodyUp {
            isCarBodyUp = status
            return true
        } else {
            return false
        }
    }
 }
 
 extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
            Грузовой автомобиль
            Модель: \(brand)
            Год выпуска: \(year)
            Объем багажника: \(trunkVolume)
            Наличие прицепа: \(haveTrailer ? "Есть" : "Нет")
            Состояние двигателя: \(isEngineStarted ? "Запущен" : "Остановлен"), \
            Состояние окон: \(isWindowsOpened ? "Открыты" : "Закрыты"), \
            Состояние кузова: \(isCarBodyUp ? "Поднят" : "Опущен")

            """
    }
 }
 
 var hyundaiTrunk = TrunkCar (brand: .Hyundai, year: 2020, trunkVolume: 40000, haveTrailer: false)
 hyundaiTrunk.windows(status: true)
 hyundaiTrunk.carBody(status: true)
 print(hyundaiTrunk)
 
