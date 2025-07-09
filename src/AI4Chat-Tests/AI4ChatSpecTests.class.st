Class {
	#name : 'AI4ChatSpecTests',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'AI4Chat-Tests',
	#package : 'AI4Chat-Tests'
}

{ #category : 'running' }
AI4ChatSpecTests >> setUp [

   super setUp.
   presenter := AI4ChatSpec new.
]

{ #category : 'running' }
AI4ChatSpecTests >> tearDown [ 

    presenter window ifNotNil: [ :w | w close ].
    super tearDown
]

{ #category : 'running' }
AI4ChatSpecTests >> testAddNewChat [ 

    presenter open.
    self assert: presenter notebook pages size equals: 1.

    presenter addNewChat.
    self assert: presenter notebook pages size equals: 2.
    self assert: presenter notebook selectedPage title equals: 'New Chat'
]
