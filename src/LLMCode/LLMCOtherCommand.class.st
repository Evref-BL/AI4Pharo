Class {
	#name : #LLMCOtherCommand,
	#superclass : #SycSourceCodeCommand,
	#traits : 'TRefactoringCommandSupport',
	#classTraits : 'TRefactoringCommandSupport classTrait',
	#category : #LLMCode
}

{ #category : #activation }
LLMCOtherCommand class >> contextMenuOrder [
	^ 1000
]

{ #category : #activation }
LLMCOtherCommand class >> sourceCodeMenuActivation [

	<classAnnotation>
	^ SycLLMMenuActivation
		  byItemOf: ClyLLMMenuGroup
		  order: self contextMenuOrder
		  for: ClySourceCodeContext
]

{ #category : #accessing }
LLMCOtherCommand >> defaultMenuItemName [

	^ 'AI.Other'
]

{ #category : #accessing }
LLMCOtherCommand >> execute [

	Transcript crShow: 'Comment ', method name.
	
]
