Class {
	#name : #LLMCommentor,
	#superclass : #Object,
	#instVars : [
		'ollama'
	],
	#category : #LLMCommentor
}

{ #category : #'as yet unclassified' }
LLMCommentor >> buildMethodContext: aPharoMethod [
	|loc selector context sourcecode|
	loc := aPharoMethod sourceCode lines .
	selector := loc first .
	sourcecode :=  '' join: (loc copyWithoutFirst: selector).
	
	context := 'Method name: #', String cr, 
	selector, String cr, 
	String cr, 'Method source code: ',String cr, sourcecode , String cr.
	
^ context 
]

{ #category : #'as yet unclassified' }
LLMCommentor >> buildPromptWithContext: aPharoMethod [. 
	^ LLMPromptBuilder new
		  role: 'You are a smalltalk developper. You write one line comments for the methods using the context.';
		  context: (self buildMethodContext: aPharoMethod);
		  task: 'Your comment must summarize the method behavior. Only answer as smalltalk comment';
		  buildPrompt
]

{ #category : #'as yet unclassified' }
LLMCommentor >> generateCommentForMethod: aPharoMethod [

	|loc selector comment sourcecode prompt|
	
	loc := aPharoMethod sourceCode lines .
	selector := loc first .
	
	sourcecode :=  '' join: (loc copyWithoutFirst: selector)  .

	prompt := self buildPromptWithContext: aPharoMethod. 
	 comment := ollama query: prompt.

	aPharoMethod classBinding value compile: (String cr join: { selector . comment . sourcecode }).
	
	^ aPharoMethod reformat.
	
]

{ #category : #'as yet unclassified' }
LLMCommentor >> generateMethodsCommentForClass: myClass [

| noComments |

"myClass := LLMPromptBuilder."

noComments := myClass methods select: [ :m | 
	m comments isEmpty.
	 ].

noComments do: [ :m |
	self generateCommentForMethod: m ].



]

{ #category : #initialization }
LLMCommentor >> initialize [ 
	
	ollama := OllamaAPI new.
	ollama model: OPhindCodeLlamaModel new.
	ollama model tag: '34b-v2'.
	ollama stream: false. 
]
