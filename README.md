# AI4Pharo

This is an extension of the Pharo to integrate many LLM in the IDE.
To query an LLM I use the [Pharo LLM project](https://github.com/Evref-BL/Pharo-LLMAPI) to do whatever we want.

## Installation

Execute the following in a Pharo Playground

```st
Metacello new
  githubUser: 'Evref-BL' project: 'AI4Pharo' commitish: 'main' path: 'src';
  baseline: 'AI4Pharo';
  load
```

Then, in Settings > Tools > Debugging > DebuggerExtension > LLMDebugger > Activate the extension.

## Usage

When the debugger popup, you have a right panel that allows you to prompt the LLM
