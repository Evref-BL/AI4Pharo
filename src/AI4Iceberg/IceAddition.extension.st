Extension { #name : 'IceAddition' }

{ #category : '*AI4Iceberg' }
IceAddition >> printOnLLMQuery: aWriteStream [ 
	aWriteStream << 'addition'; << String lf.
	aWriteStream << self leftContents.
]
