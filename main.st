Object subclass: Main[
    |fileName args action employeesList fileReadSuccess operation threshold|

    parseArgs [
        "Read the file name from as a commandline argument"
        args := Smalltalk arguments.

        "Check if the number of arguments is correct"
        (args size < 2 or: [args size > 4]) ifTrue: [
            ('Usage: gst employee.st salaried.st hourly.st commission.st -f main.st datafile action') displayNl.
            'or' displayNl.
            ('Usage: gst employee.st salaried.st hourly.st commission.st -f main.st datafile action operator threshold') displayNl.
            '' displayNl.
            'Valid actions: count print min max total avg' displayNl.
            'Valid operators: eq ne gt ge lt le' displayNl.
            ^false.
        ].
        fileName := args at: 1.
        action := args at: 2.
        ^true
    ]

    readFile [
        |line fileExists f|
        fileReadSuccess := false.
        fileExists := File exists: fileName.
        fileExists 
            ifFalse: [
                ('Unable to open ', fileName, ' for reading') displayNl.
                ^false.
            ].
        
        f:=FileStream open: fileName mode: #read.
        "If file does not exist, then exit"
        employeesList := OrderedCollection new.
        [f atEnd] whileFalse:
            [
                |tokens type newEmployee|
                line := f nextLine.
                tokens := line subStrings.
                tokens size > 0 ifTrue: [
                type := tokens at: 1.
                " tokens displayNl. "
                    type = 'hourly' ifTrue: [
                        newEmployee := HourlyEmployee new.
                        newEmployee setFirstName: (tokens at: 2).
                        newEmployee setLastName: (tokens at: 3).
                        newEmployee setNumHours: (tokens at: 4) asInteger.
                        newEmployee setHourlyRate: (tokens at: 5) asNumber asFloat.
                        " newEmployee printInfo. "
                        " newEmployee getEarning printNl. "
                        " tokens displayNl. "
                    ].
                    type = 'salaried' ifTrue: [
                        newEmployee := SalariedEmployee new.
                        newEmployee setFirstName: (tokens at: 2).
                        newEmployee setLastName: (tokens at: 3).
                        newEmployee setWeeklySalary: (tokens at: 4) asNumber asFloat.
                        " newEmployee printInfo. "
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
                        " newEmployee printInfo. "
                        " newEmployee getEarning printNl. "
                        " tokens displayNl. "
                    ].
                    employeesList add: newEmployee. 
                ].
            ].
        action := args at: 2.
        args size = 4 ifTrue: [
            operation := args at: 3.
            threshold := (args at: 4) asNumber asFloat.
        ].
        " ('action is: ', action) displayNl. "
        " action = 'print' ifTrue: [
            employeesList do: [:each | each printInfo. each getEarning printNl].
        ]. "
        fileReadSuccess := true.
        ^employeesList.
    ]

    isFileReadSuccess [
        ^fileReadSuccess
    ]

    printFunc [
        employeesList do: [:each | each printInfo. ('earned $', (each getEarning) printString) displayNl. '' displayNl.].
    ]

    performThresOperation: lhs right: rhs  [
        operation = 'eq' ifTrue: [
            ^lhs = rhs.
        ].
        operation = 'ne' ifTrue: [
            ^lhs ~= rhs.
        ].
        operation = 'gt' ifTrue: [
            ^lhs > rhs.
        ].
        operation = 'ge' ifTrue: [
            ^lhs >= rhs.
        ].
        operation = 'lt' ifTrue: [
            ^lhs < rhs.
        ].
        operation = 'le' ifTrue: [
            ^lhs <= rhs.
        ].
    ]

    updateEmployeesListBasedOnCond [
        employeesList := employeesList select: [:each | self performThresOperation: (each getEarning) right: threshold].
        " employeesList := employeesList select: [:each | 3< (each getEarning)]. "
    ]


    parseActions [
        args size = 4 ifTrue: [
            self updateEmployeesListBasedOnCond.
        ].
        action = 'count' ifTrue: [
            ('There are ', (employeesList size) printString, ' employees') displayNl.
        ].
        action = 'min' ifTrue: [
            |min minEmployee|

            min := (employeesList at: 1) getEarning.
            minEmployee := employeesList at: 1.

            employeesList do: [:each | 
                ((each getEarning) < min) 
                    ifTrue: [
                        min := each getEarning.
                        minEmployee := each.
                    ].
            ].
            minEmployee printInfo.
            ('earned $', (minEmployee getEarning) printString) displayNl.
        ].
        action = 'max' ifTrue: [
            |max maxEmployee|

            max := (employeesList at: 1) getEarning.
            maxEmployee := employeesList at: 1.

            employeesList do: [:each | 
                ((each getEarning) > max) 
                    ifTrue: [
                        max := each getEarning.
                        maxEmployee := each.
                    ].
            ].
            maxEmployee printInfo.
            ('earned $', (maxEmployee getEarning) printString) displayNl.
        ].
        action = 'total' ifTrue: [
            |total|
            total := 0.
            employeesList do: [:each | total := total + each getEarning].
            ('Total payment is $', (total * 1.0) printString) displayNl.
        ].
        action = 'avg' ifTrue: [
            |total|
            total := 0.
            employeesList do: [:each | total := total + each getEarning].
            ('Average payment per employee is $', (total / (employeesList size)) printString) displayNl.
        ].
        action = 'print' ifTrue: [
            self printFunc.
        ].
    ]

    Main class >> main [
        |m|
        m := Main new.
        m parseArgs ifTrue: [
            |employeesList|
            employeesList:= m readFile.
            (m isFileReadSuccess) ifTrue: [
                " 'file read successfully' displayNl. "
                m parseActions.
            ]. 
        ].
    ]

]

Main main.
