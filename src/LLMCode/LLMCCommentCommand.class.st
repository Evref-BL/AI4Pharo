Class {
	#name : #LLMCCommentCommand,
	#superclass : #SycSourceCodeCommand,
	#traits : 'TRefactoringCommandSupport',
	#classTraits : 'TRefactoringCommandSupport classTrait',
	#category : #LLMCode
}

{ #category : #activation }
LLMCCommentCommand class >> contextMenuOrder [

	^ 10
]

{ #category : #activation }
LLMCCommentCommand class >> sourceCodeMenuActivation [

	<classAnnotation>
	^ SycLLMMenuActivation
		  byItemOf: ClyLLMMenuGroup
		  order: self contextMenuOrder
		  for: ClySourceCodeContext
]

{ #category : #accessing }
LLMCCommentCommand >> defaultMenuItemName [

	^ 'AI.Comment '
]

{ #category : #execution }
LLMCCommentCommand >> execute [
	" Creates an instance of LLMCommentor and generates a comment for the current method."

	| commentor |
	commentor := LLMCommentor new.
	commentor generateCommentForMethod: self method
]
