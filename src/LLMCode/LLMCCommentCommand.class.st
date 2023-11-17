Class {
	#name : #LLMCCommentCommand,
	#superclass : #SycSourceCodeCommand,
	#traits : 'TRefactoringCommandSupport',
	#classTraits : 'TRefactoringCommandSupport classTrait',
	#category : #LLMCode
}

{ #category : #activation }
LLMCCommentCommand class >> sourceCodeMenuActivation [

	<classAnnotation>
	^ SycLLMMenuActivation
		  byItemOf: ClyQueryMenuGroup
		  for: ClySourceCodeContext
]

{ #category : #accessing }
LLMCCommentCommand >> defaultMenuItemName [

	^ 'AI.Comment '
]

{ #category : #accessing }
LLMCCommentCommand >> execute [

	Transcript crShow: 'Comment ', method name.
	
]
