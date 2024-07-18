Class {
	#name : 'BaselineOfAI4Pharo',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAI4Pharo',
	#package : 'BaselineOfAI4Pharo'
}

{ #category : 'baselines' }
BaselineOfAI4Pharo >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfAI4Pharo >> defineDependencies: spec [

	spec
		baseline: 'PharoHuggingFace'
		with: [
		spec repository: 'github://Evref-BL/Pharo-HuggingFace:main/src' ].
	spec
		baseline: 'PharoOllama'
		with: [
		spec repository: 'github://Evref-BL/Pharo-OllamaAPI:main/src' ].
	spec
		baseline: 'PharoOpenAIAPI'
		with: [
		spec repository: 'github://Evref-BL/Pharo-OpenAI:main/src' ]
]

{ #category : 'baselines' }
BaselineOfAI4Pharo >> defineGroups: spec [
]

{ #category : 'baselines' }
BaselineOfAI4Pharo >> definePackages: spec [

	spec package: 'LLMDebugger' with: [
		spec requires:
			#( 'PharoHuggingFace' 'PharoOllama' 'PharoOpenAIAPI' ) ].
	spec
		package: 'AI4Iceberg'
		with: [ spec requires: #( 'PharoOllama' ) ].
	spec package: 'LLMCommentor'.
	spec package: 'LLMCode'
]
