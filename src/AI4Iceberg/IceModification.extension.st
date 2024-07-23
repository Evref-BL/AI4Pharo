Extension { #name : 'IceModification' }

{ #category : '*AI4Iceberg' }
IceModification >> printOnLLMQuery: aWriteStream [

	| diffMorph diffs |
	diffMorph := DiffMorph
		             from: self oldDefinition sourceCode
		             to: self definition sourceCode.
	diffs := diffMorph allDifferences.
	diffs do: [ :diff |
		aWriteStream
			<< 'modification from:';
			<< String lf.
		aWriteStream
			<< (self oldDefinition sourceCode
					 copyFrom: diff key first
					 to: diff key last);
			<< String lf.
		aWriteStream
			<< 'to:';
			<< String lf.
		aWriteStream
			<< (self definition sourceCode
					 copyFrom: diff value first
					 to: diff value last);
			<< String lf ]
]
