Object subclass: Main[
|fileName args action fileReadSuccess|

parseArgs [
    "Read the file name from as a commandline argument"
    args := Smalltalk arguments.

    "Check if the number of arguments is correct"
    (args size < 2) ifTrue: [
        ('Usage: gst employee.st salaried.st hourly.st commission.st -f main.st <filename> <action>') displayNl.
        ('       or gst employee.st salaried.st hourly.st commission.st -f main.st <filename> <action> <operator> <threshold>') displayNl.
        ^false.
    ].
    fileName := args at: 1.
    action := args at: 2.
    ^true
]

readFile [
    |line fileExists employeesList f|
    fileExists := File exists: fileName.
    fileExists 
        ifFalse: [
            ('Unable to open ', fileName, ' for reading') displayNl.
            ^false.
        ].
    
    f:=FileStream open: fileName mode: #read.
    "If file does not exist, then exit"
    line := f nextLine.
    employeesList := OrderedCollection new.
    [f atEnd] whileFalse:
        [
            |tokens type newEmployee|
            tokens := line subStrings.
            type := tokens at: 1.
            " tokens displayNl. "
            type = 'hourly' ifTrue: [
                newEmployee := HourlyEmployee new.
                newEmployee setFirstName: (tokens at: 2).
                newEmployee setLastName: (tokens at: 3).
                newEmployee setNumHours: (tokens at: 4) asInteger.
                newEmployee setHourlyRate: (tokens at: 5) asNumber asFloat.
                newEmployee printInfo.
                " newEmployee getEarning printNl. "
                " tokens displayNl. "
            ].
            type = 'salaried' ifTrue: [
                newEmployee := SalariedEmployee new.
                newEmployee setFirstName: (tokens at: 2).
                newEmployee setLastName: (tokens at: 3).
                newEmployee setWeeklySalary: (tokens at: 4) asNumber asFloat.
                newEmployee printInfo.
                " newEmployee getEarning printNl. "
                " tokens displayNl. "
            ].
            type = 'commission' ifTrue: [
                newEmployee := CommissionEmployee new.
                newEmployee setFirstName: (tokens at: 2).
                newEmployee setLastName: (tokens at: 3).
                newEmployee setMinWeekPay: (tokens at: 4) asInteger.
                newEmployee setSalesAmount: (tokens at: 5) asInteger.
                newEmployee setCommissionRate: (tokens at: 6) asNumber asFloat.
                newEmployee printInfo.
                " newEmployee getEarning printNl. "
                " tokens displayNl. "
            ].
            employeesList add: newEmployee. 
            line := f nextLine.
        ].
    action := args at: 2.
    " action = 'print' ifTrue: [
        employeesList do: [:each | each printInfo. each getEarning printNl].
    ]. "
    fileReadSuccess := true.
    ^employeesList.
]

]

|m|
m := Main new.
m parseArgs ifTrue: [
    |employeesList|
    employeesList:= m readFile.
    " fileReadSuccess ifTrue: [
        m employeesList do: [:each | each printInfo. each getEarning printNl]. 
        'file read successfully' displayNl.
    ]. "
].
