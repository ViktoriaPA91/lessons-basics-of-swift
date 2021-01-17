import UIKit

enum CarBrand {
    case Hyundai, Mazda, Geely, Mersedes, Volvo
}

enum CarTransmission {
    case full, front, back
}

enum CarAction {
    case startEngine, stopEngine
    case openWindows, closeWindows
    case putInTrunk(volume: UInt32), unloadFromTrunk(volume: UInt32)
    case upCarBody, downCarBody
    case openManhole, closeManhole
}

class Car : CustomStringConvertible {
    
    let brand: CarBrand
    let year: UInt16
    let trunkVolume: UInt16
    var isEngineStarted: Bool = false
    var isWindowsOpened: Bool = false
    var currentFillTrankVolume: UInt16 = 0
    
    var description: String {
        return "Модель: \(brand)\nГод выпуска: \(year), объем багажника: \(trunkVolume), запущен ли двигатель: \(isEngineStarted), открыты ли окна: \(isWindowsOpened), заполненный объем багажника: \(currentFillTrankVolume)"
    }
    
    init(brand: CarBrand, year: UInt16, trunkVolume: UInt16) {
        self.brand = brand
        self.year = year
        self.trunkVolume = trunkVolume
    }
    
    func run(action: CarAction) -> Bool {
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
        default:
            return false
        }
        return false
    }
}

class SportCar: Car {
    let transmission: CarTransmission
    var isManholeOpened: Bool = false
    
    override var description: String {
        return super.description + ", Трансмиссия: \(transmission), открыт ли люк: \(isManholeOpened)"
    }
    
    init(brand: CarBrand, year: UInt16, trunkVolume: UInt16, transmission: CarTransmission) {
        self.transmission = transmission
        super.init(brand: brand, year: year, trunkVolume: trunkVolume)
    }
    override func run(action: CarAction) -> Bool {
        switch action {
        case .openManhole:
            if !isManholeOpened {
                self.isManholeOpened = true
                return true
            }
        case .closeManhole:
            if isManholeOpened {
                self.isManholeOpened = false
                return true
            }
        default:
            return super.run(action: action)
        }
        return false
    }
}

class TrunkCar: Car {
    let haveTrailer: Bool
    var isCarBodyUp: Bool = false
    
    override var description: String {
        return super.description + ", наличие прицепа: \(haveTrailer), поднят ли кузов: \(isCarBodyUp)"
    }
    init(brand: CarBrand, year: UInt16, trunkVolume: UInt16, haveTrailer: Bool) {
        self.haveTrailer = haveTrailer
        super.init(brand: brand, year: year, trunkVolume: trunkVolume)
    }
    override func run(action: CarAction) -> Bool {
        switch action {
        case .upCarBody:
            if !isCarBodyUp {
                self.isCarBodyUp = true
                return true
            }
        case .downCarBody:
            if isCarBodyUp {
                self.isCarBodyUp = false
                return true
            }
        default:
            return super.run(action: action)
        }
        return false
    }
}

var geelyEmgrandGT = SportCar(brand: .Geely, year: 2016, trunkVolume: 500, transmission: .front)
geelyEmgrandGT.run(action: .openManhole)
print(geelyEmgrandGT)

var hyundaiTrunk = TrunkCar (brand: .Hyundai, year: 2020, trunkVolume: 40000, haveTrailer: false)
hyundaiTrunk.run(action: .upCarBody)
print(hyundaiTrunk)
