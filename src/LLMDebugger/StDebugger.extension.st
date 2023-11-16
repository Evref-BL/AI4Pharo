Extension { #name : #StDebugger }

{ #category : #'*LLMDebugger' }
StDebugger >> createMissingMethodAndGenerate [

	| msg chosenClass |
	self flag: #DBG_MISSINGTEST.
	msg := self interruptedContext tempAt: 1.
	[ 
	chosenClass := self requestClassFrom:
		               self interruptedContext receiver class.
	self createMissingMethodFor: msg in: chosenClass ]
		on: Abort
		do: [ ^ self ].
	
	code text: (self ollamaGenerateMethodFor: msg in: chosenClass).
	
	code takeKeyboardFocus 
]

{ #category : #'*LLMDebugger' }
StDebugger >> generateMethodFor: msg in: class [

	| api object aPrompt openAIResult |
	api := OAApi new.
	object := OARequestObject new.

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
		           stream << msg arguments size printString.
		           stream << ' arguments.'.
		           stream << String crlf.
		           stream << 'Generate the code' ].
	aPrompt recordInfo.
	object addMessage: (OARequestMessage new
			 content: aPrompt;
			 yourself).

	api content: object.
	openAIResult := api perform.

	^ openAIResult choices anyOne message at: #content
]

{ #category : #'*LLMDebugger' }
StDebugger >> ollamaGenerateMethodFor: msg in: class [

	| api aPrompt openAIResult |
	

	api := OllamaAPI new.
	api model: OPhindCodeLlamaModel new.
	api model tag: '34b-v2'.
	api stream: false.

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
		           stream << msg arguments size printString.
		           stream << ' arguments.'.
		           stream << String crlf.
		           stream << 'Generate the code' ].
	aPrompt recordInfo.
	

	openAIResult := api query: aPrompt.
	

	^ openAIResult 
]

{ #category : #'*LLMDebugger' }
StDebugger >> openIAgenerateMethodFor: msg in: class [

	| api object aPrompt openAIResult |
	api := OAApi new.
	object := OARequestObject new.

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
		           stream << msg arguments size printString.
		           stream << ' arguments.'.
		           stream << String crlf.
		           stream << 'Generate the code' ].
	aPrompt recordInfo.
	object addMessage: (OARequestMessage new
			 content: aPrompt;
			 yourself).

	api content: object.
	openAIResult := api perform.

	^ openAIResult choices anyOne message at: #content
]
