|fileName line args fileExists|
"Read the file name from as a commandline argument"
args := Smalltalk arguments.
fileName := args at: 1.
" fileName := FileStream stdin nextLine.  "
"If file does not exist, then exit"
fileExists := File exists: fileName.
fileExists 
    ifFalse: ['File not found' displayNl. ]
    ifTrue: [
        " fileName := 'employees.dat'. "
        f:=FileStream open: fileName mode: #read.
        "If file does not exist, then exit"
        f ifNil: [Transcript show: 'File not found'; cr. Smalltalk halt].
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
    ].
