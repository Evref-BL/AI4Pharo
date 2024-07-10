Extension { #name : 'IceTipCommitBrowser' }

{ #category : '*AI4Iceberg' }
IceTipCommitBrowser >> initializePresenters [

	diffPanel := self instantiate: IceTipDiffSelectingPanel on: self model diffToReferenceCommit.
	diffPanel leftLabel: 'Repository'.
	diffPanel rightLabel: 'Working Copy'.
	
	commentPanel := self instantiate: LLMIceTipCommentPanel on: self repositoryModel.
	commentPanel onCommit: [ self doCommit ].
	
	self initializeAcceptShortcut
]
