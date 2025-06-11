Extension { #name : 'StDebugger' }

{ #category : '*LLMDebugger' }
StDebugger >> createMissingMethodAndGenerate [

	| method |
	self implementMissingMethod.
	method := (self stackTable itemAt: 1) method.
	code text: (self generateMethodFor: method in: method class).
	code takeKeyboardFocus 
]

{ #category : '*LLMDebugger' }
StDebugger >> generateMethodFor: msg in: class [

	| api aPrompt |
	api := LLMAPI chat.

	aPrompt := String streamContents: [ :stream |
			           stream << '## Usage example'.
			           stream << String crlf.
			           stream << self stack second method sourceCode.
			           stream << String crlf.
			           stream << '## Definition'.
			           stream << String crlf.
			           stream << 'Class Name: '.
			           stream << class name.
			           stream << String crlf.
			           stream << 'Class methods: '.
			           class methods
				           do: [ :m | stream << m name printString ]
				           separatedBy: [ stream << ', ' ].
			           stream << String crlf.
			           stream << 'Generate the Pharo method '.
			           stream << msg selector.
			           stream << String crlf.
			           stream << 'The Method has '.
			           stream << msg numArgs printString.
			           stream << ' arguments.'.
			           stream << String crlf.
			           stream << 'Generate the code and only the code. Do not add any comment. It should compile and allows the execution' ].
	api payload temperature: 0.7.
	api payload model: 'devstral'.
	api payload top_p: 0.9.
	api payload messages: {
			(LLMAPIChatObjectMessage
				 role: 'system'
				 content:
				 'You are a good developer. Based on the context code diff. Write a commit message. No additionnal comment. Only commit message.').
			(LLMAPIChatObjectMessage role: 'user' content: aPrompt) }.

	^ api performRequest
]
