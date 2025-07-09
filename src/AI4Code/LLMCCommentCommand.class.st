Class {
	#name : 'LLMCCommentCommand',
	#superclass : 'SycSourceCodeRefactoringCommand',
	#traits : 'TRefactoringCommandSupport',
	#classTraits : 'TRefactoringCommandSupport classTrait',
	#category : 'AI4Code',
	#package : 'AI4Code'
}

{ #category : 'activation' }
LLMCCommentCommand class >> contextMenuOrder [

	^ 10
]

{ #category : 'activation' }
LLMCCommentCommand class >> sourceCodeMenuActivation [

	<classAnnotation>
	^ SycLLMMenuActivation
		  byItemOf: ClyLLMMenuGroup
		  order: self contextMenuOrder
		  for: ClySourceCodeContext
]

{ #category : 'execution' }
LLMCCommentCommand >> asRefactorings [

	| commentor newComment |
	commentor := LLMCommentor new.
	newComment := commentor generateCommentForMethod: self method.

	^ { (RBAddMethodCommentTransformation
		   comment: newComment
		   inMethod: method selector
		   inClass: method origin) }
]

{ #category : 'accessing' }
LLMCCommentCommand >> defaultMenuItemName [

	^ 'AI.Comment '
]
