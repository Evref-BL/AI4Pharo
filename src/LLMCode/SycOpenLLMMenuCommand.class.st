Class {
	#name : #SycOpenLLMMenuCommand,
	#superclass : #SycOpenContextMenuCommand,
	#category : #LLMCode
}

{ #category : #execution }
SycOpenLLMMenuCommand >> activationStrategy [

	^ SycLLMMenuActivation
]

{ #category : #'context menu' }
SycOpenLLMMenuCommand >> cmCommandClass [

	^ SycSourceCodeCmCommand
]

{ #category : #accessing }
SycOpenLLMMenuCommand >> defaultMenuItemName [

	^ 'AI Menu'
]
