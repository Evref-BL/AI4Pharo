Class {
	#name : 'LLMCommentor',
	#superclass : 'Object',
	#instVars : [
		'api'
	],
	#category : 'LLMCommentor',
	#package : 'LLMCommentor'
}

{ #category : 'as yet unclassified' }
LLMCommentor >> buildMethodContext: aPharoMethod [

	| loc selector sourcecode |
	^ String streamContents: [ :stream |
		  loc := aPharoMethod sourceCode lines.
		  selector := loc first.
		  sourcecode := '' join: (loc copyWithoutFirst: selector).

		  stream
			  << 'Method name: #';
			  << String cr;
			  << selector;
			  << String cr;
			  << String cr;
			  << 'Method source code: ';
			  << String cr;
			  << sourcecode;
			  << String cr ]
]

{ #category : 'as yet unclassified' }
LLMCommentor >> buildPromptWithContext: aPharoMethod [

	^ LLMPromptBuilder new
		  role:
			  'You are a smalltalk developper. You write a one line comment for the methods using the context.';
		  context: (self buildMethodContext: aPharoMethod);
		  task:
			  'Your comment must summarize the method behavior. Only answer as smalltalk comment';
		  buildPrompt
]

{ #category : 'as yet unclassified' }
LLMCommentor >> generateCommentForMethod: aPharoMethod [

	| comment prompt |
	prompt := self buildPromptWithContext: aPharoMethod.
	api payload
		temperature: 0.5;
		model: 'devstral';
		top_p: 1;
		max_tokens: 250;
		messages: {
				(LLMAPIChatObjectMessage
					 role: 'system'
					 content: 'You are a usefull assistant').
				(LLMAPIChatObjectMessage role: 'user' content: prompt) }.
	comment := api performRequest.
	^ comment
]

{ #category : 'as yet unclassified' }
LLMCommentor >> generateMethodsCommentForClass: myClass [

	| noComments |
	noComments := myClass methods select: [ :m | m comments isEmpty ].

	noComments do: [ :m | self generateCommentForMethod: m ]
]

{ #category : 'initialization' }
LLMCommentor >> initialize [
	"Initialize the instance by setting up a new OllamaAPI object and disabling streaming."

	super initialize.
	api := LLMAPI chat
]
