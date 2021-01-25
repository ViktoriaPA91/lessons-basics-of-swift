import UIKit

enum CarBrand {
    case Hyundai, Mazda, Geely, Mersedes, Volvo
}

enum CarAction {
    case startEngine, stopEngine
    case openWindows, closeWindows
    case openManhole, closeManhole
    case putInTrunk(volume: UInt32), unloadFromTrunk(volume: UInt32)
}

enum ActionError: Error {
    case engineStarted
    case engineStopрed
    case windowsOpened
    case windowsClosed
    case manholeOpened
    case manholeClosed
    case notEnoughSpaceInTrunk
    case trunkIsEmpty
}

enum TrailerVolumeError: Error {
    case haveNotTrailer
}

class TrunkCar : CustomStringConvertible {
    
    let brand: CarBrand
    let year: UInt16
    let trailerVolume: UInt?
    var isEngineStarted: Bool = false
    var isWindowsOpened: Bool = false
    
    var description: String {
        return """
                Грузовой автомобиль
                Модель: \(brand)
                Год выпуска: \(year)
                Наличие прицепа: \(trailerVolume != nil)\
                \(trailerVolume == nil ? "" : "\nОбъем прицепа: \(trailerVolume!)")
                Состояние двигателя: \(isEngineStarted ? "Запущен" : "Остановлен"); \
                Состояние окон: \(isWindowsOpened ? "Открыты" : "Закрыты")

                """
    }
    
    init(brand: CarBrand, year: UInt16, trailerVolume: UInt? = nil) {
        self.brand = brand
        self.year = year
        self.trailerVolume = trailerVolume
    }
    
    func run(action: CarAction) -> (Bool?, ActionError?){
        switch action {
        case .startEngine:
            guard !isEngineStarted else {
                return (nil, ActionError.engineStarted)
            }
            self.isEngineStarted = true
        case .stopEngine:
            guard isEngineStarted else {
                return (nil, ActionError.engineStopрed)
            }
            self.isEngineStarted = false
        case .openWindows:
            guard !isWindowsOpened else {
                return (nil, ActionError.windowsOpened)
            }
            self.isWindowsOpened = true
        case .closeWindows:
            guard isWindowsOpened else {
                return (nil, ActionError.windowsClosed)
            }
            self.isWindowsOpened = false
        default:
            return (false, nil)
        }
        return (true, nil)
    }
    
    func getTrailerVolume() -> (UInt?, TrailerVolumeError?) {
        if let trailerVolume = self.trailerVolume {
            return (trailerVolume, nil)
        } else {
            return (nil, TrailerVolumeError.haveNotTrailer)
        }
    }
}

let trunk1 = TrunkCar(brand: .Hyundai, year: 2020)
trunk1.run(action: .openWindows)
let trunk2 = TrunkCar(brand: .Mersedes, year: 2010, trailerVolume: 40000)

print(trunk1)
print(trunk2)

class SportCar : CustomStringConvertible {
    
    let brand: CarBrand
    let year: UInt16
    let trunkVolume: UInt16
    var isEngineStarted: Bool = false
    var isWindowsOpened: Bool = false
    var isManholeOpened: Bool = false
    var currentFillTrankVolume: UInt16 = 0
    
    var description: String {
        return """
            Легковой автомобиль
            Модель: \(brand)
            Год выпуска: \(year)
            Объем багажника: \(trunkVolume)
            Состояние двигателя: \(isEngineStarted ? "Запущен" : "Остановлен"); \
            Состояние окон: \(isWindowsOpened ? "Открыты" : "Закрыты"); \
            Состояние люка: \(isManholeOpened ? "Открыт" : "Закрыт")
            Заполненный объем багажника: \(currentFillTrankVolume)

            """
    }
    
    init(brand: CarBrand, year: UInt16, trunkVolume: UInt16) {
        self.brand = brand
        self.year = year
        self.trunkVolume = trunkVolume
    }
    
    func run(action: CarAction) throws {
        switch action {
        case .startEngine:
            guard !isEngineStarted else {
                throw ActionError.engineStarted
            }
            self.isEngineStarted = true
        case .stopEngine:
            guard isEngineStarted else {
                throw ActionError.engineStopрed
            }
            self.isEngineStarted = false
        case .openWindows:
            guard !isWindowsOpened else {
                throw ActionError.windowsOpened
            }
            self.isWindowsOpened = true
        case .closeWindows:
            guard isWindowsOpened else {
                throw ActionError.windowsClosed
            }
            self.isWindowsOpened = false
        case .openManhole:
            guard !isManholeOpened else {
                throw ActionError.manholeOpened
            }
            self.isManholeOpened = true
        case .closeManhole:
            guard  isManholeOpened else {
                throw ActionError.manholeClosed
            }
            self.isManholeOpened = false
        case .putInTrunk(volume: let volume):
            guard trunkVolume - currentFillTrankVolume >= volume else {
                throw ActionError.notEnoughSpaceInTrunk
            }
            self.currentFillTrankVolume += UInt16(volume)
        case .unloadFromTrunk(volume: let volume):
            guard currentFillTrankVolume >= volume else {
                throw ActionError.trunkIsEmpty
            }
            self.currentFillTrankVolume -= UInt16(volume)
        }
    }
}

let geelyEmgrandGT = SportCar(brand: .Geely, year: 2016, trunkVolume: 500)

do {
    try geelyEmgrandGT.run(action: .closeWindows)
} catch let error {
    print("Произошла ошибка: \(error.localizedDescription)")
}

do {
    try geelyEmgrandGT.run(action: .putInTrunk(volume: 500))
} catch let error {
    print("Произошла ошибка: \(error.localizedDescription)")
}

try? geelyEmgrandGT.run(action: .closeManhole)
try? geelyEmgrandGT.run(action: .startEngine)

print(geelyEmgrandGT)
