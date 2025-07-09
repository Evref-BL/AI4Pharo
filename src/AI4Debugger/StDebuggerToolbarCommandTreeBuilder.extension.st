Extension { #name : 'StDebuggerToolbarCommandTreeBuilder' }

{ #category : '*AI4Debugger' }
StDebuggerToolbarCommandTreeBuilder >> contextControlCommandClasses [
	^ {StDefineMissingEntityCommand . StLLMDefineMethodCommand}
]
