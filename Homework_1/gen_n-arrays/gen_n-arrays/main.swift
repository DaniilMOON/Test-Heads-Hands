class Application {
    var sizeArray: Int = 0
    var array: [[Int]] = []
    var sizeLineInArray: [Int] = []
    
    init(n: Int) {
        setSizeArray(sizeArray: n)
        
        var sizeLine: Set<Int> = []
        let minSizeLine = 1, maxSizeLine = 2 * sizeArray
        while (sizeLine.count != self.sizeArray) {
            sizeLine.insert(Int.random(in: minSizeLine...maxSizeLine))
        }
        setSizeLineInArray(sizeLineInArray: Array(sizeLine))
        
        setArray()
        
    }
    
    init() {
        
    }
    
    func setSizeArray(sizeArray: Int) {
        self.sizeArray = sizeArray;
    }
    
    func getSizeArray() -> Int {
        return self.sizeArray
    }
    
    func setSizeLineInArray(sizeLineInArray: [Int]) {
        self.sizeLineInArray = sizeLineInArray;
    }
    
    func getSizeLineInArray(sizeLineInArray: [Int]) -> [Int] {
        return self.sizeLineInArray
    }
    
    func getArray() -> [[Int]] {
        return self.array
    }
    
    func setArray() {
        let minValue = 0, maxValue = 10
        for numLine in 0..<sizeArray {
            var lineInArray: [Int] = []
            let curSizeLine = sizeLineInArray[numLine]
            for _ in 0..<curSizeLine {
                lineInArray.append(Int.random(in: minValue..<maxValue))
            }
            array.append(lineInArray)
        }
    }
    
    func printArray() {
        for line in array {
            for curEl in line {
                print(curEl, terminator: " ")
            }
            print()
        }
    }
    
    func sortLineInArray() {
        for numLine in 0..<array.count {
            if numLine % 2 == 0 {
                array[numLine] = array[numLine].sorted()
            } else {
                array[numLine] = array[numLine].sorted(by: >)
            }
        }
    }
}

var array: Application = Application()
var okInput  = false
while (!okInput) {
    print("Input n - ", terminator: "")
    let n = readLine()
    if let strSizeArray = n {
        if let sizeArray = Int(strSizeArray) {
            if sizeArray >= 0 {
                array = Application(n: sizeArray)
                okInput = true
            }
        }
    }
    if (!okInput){
        print("\"\(n ?? "\"Error\"")\" could not be converted to an unsigned integer")
    }
}

array.printArray()

array.sortLineInArray()

print()
array.printArray()
