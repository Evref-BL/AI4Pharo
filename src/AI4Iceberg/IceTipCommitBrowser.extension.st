Extension { #name : #IceTipCommitBrowser }

{ #category : #'*AI4Iceberg' }
IceTipCommitBrowser >> initializePresenters [

	diffPanel := self instantiate: IceTipDiffSelectingPanel on: self model workingCopyDiff.
	diffPanel leftLabel: 'Repository'.
	diffPanel rightLabel: 'Working Copy'.
	
	commentPanel := self instantiate: LLMIceTipCommentPanel on: self model.
	commentPanel onCommit: [ self doCommit ].
	
	self initializeAcceptShortcut
]
