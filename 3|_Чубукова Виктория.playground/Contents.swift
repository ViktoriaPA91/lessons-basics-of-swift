//: A UIKit based Playground for presenting user interface
  
import UIKit

// 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.


enum CarBrand: String, CustomStringConvertible {
    case Hyundai, Mazda, Geely, Mersedes, Volvo;
    
    var description: String {
        return rawValue
    }
}

enum CarAction {
    case startEngine, stopEngine
    case openWindows, closeWindows
    case putInTrunk(volume: UInt32), unloadFromTrunk(volume: UInt32)
}

struct SportCar {
    let brand: CarBrand
    let year: UInt16
    let trunkVolume: UInt16
    var isEngineStarted: Bool = false
    var isWindowsOpened: Bool = false
    var currentFillTrankVolume: UInt16 = 0
    
    mutating func run(action: CarAction) -> Bool {
        switch action {
        case .startEngine:
            if !isEngineStarted {
                self.isEngineStarted = true
                return true
            }
        case .stopEngine:
            if isEngineStarted {
                self.isEngineStarted = false
                return true
            }
        case .openWindows:
            if !isWindowsOpened {
                self.isWindowsOpened = true
                return true
            }
        case .closeWindows:
            if isWindowsOpened {
                self.isWindowsOpened = false
                return true
            }
        case .putInTrunk(volume: let volume):
            if trunkVolume - currentFillTrankVolume >= volume {
                self.currentFillTrankVolume += UInt16(volume)
                return true
            }
        case .unloadFromTrunk(volume: let volume):
            if currentFillTrankVolume >= volume {
                self.currentFillTrankVolume -= UInt16(volume)
                return true
            }
        }
        return false
    }
}

struct TrunkCar {
    let brand: CarBrand
    let year: UInt16
    let trunkVolume: UInt32
    var isEngineStarted: Bool = false
    var isWindowsOpened: Bool = false
    var currentFillTrankVolume: UInt32 = 0
    
    mutating func run(action: CarAction) -> Bool {
        switch action {
        case .startEngine:
            if !isEngineStarted {
                self.isEngineStarted = true
                return true
            }
        case .stopEngine:
            if isEngineStarted {
                self.isEngineStarted = false
                return true
            }
        case .openWindows:
            if !isWindowsOpened {
                self.isWindowsOpened = true
                return true
            }
        case .closeWindows:
            if isWindowsOpened {
                self.isWindowsOpened = false
                return true
            }
        case .putInTrunk(volume: let volume):
            if trunkVolume - currentFillTrankVolume >= volume {
                self.currentFillTrankVolume += volume
                return true
            }
        case .unloadFromTrunk(volume: let volume):
            if currentFillTrankVolume >= volume {
                self.currentFillTrankVolume -= volume
                return true
            }
        }
        return false
    }
}

var geelyEmgrandGT = SportCar(brand: .Geely, year: 2016, trunkVolume: 500)
geelyEmgrandGT.run(action: .startEngine)
geelyEmgrandGT.run(action: .putInTrunk(volume: 600))
geelyEmgrandGT.run(action: .putInTrunk(volume: 500))
geelyEmgrandGT.run(action: .unloadFromTrunk(volume: 300))
print(geelyEmgrandGT)

var hyundaiTrunk = TrunkCar (brand: .Hyundai, year: 2020, trunkVolume: 40000)
hyundaiTrunk.run(action: .openWindows)
hyundaiTrunk.run(action: .putInTrunk(volume: 20000))
print(hyundaiTrunk)

