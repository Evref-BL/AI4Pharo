Class {
	#name : 'ClyLLMMenuGroup',
	#superclass : 'CmdMenuGroup',
	#category : 'AI4Code',
	#package : 'AI4Code'
}

{ #category : 'testing' }
ClyLLMMenuGroup >> isInlined [
	"Always returns true, indicating that this method is inlined."

	^ true
]

{ #category : 'accessing' }
ClyLLMMenuGroup >> order [
	"Return 1.5 as a fixed value."

	^ 1.5
]
