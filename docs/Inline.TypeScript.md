
Inline.TypeScript
-----------------
### Synopsis
TypeScript Inline PipeScript Transpiler.

---
### Description

Transpiles TypeScript with Inline PipeScript into TypeScript.

Multiline comments with /*{}*/ will be treated as blocks of PipeScript.

Multiline comments can be preceeded or followed by 'empty' syntax, which will be ignored.

This is so that Inline PipeScript can be used with operators, and still be valid TypeScript syntax. 

The TypeScript Inline Transpiler will consider the following syntax to be empty:

* ```undefined```
* ```null```
* ```""```
* ```''```

---
### Parameters
#### **CommandInfo**

The command information.  This will include the path to the file.



> **Type**: ```[CommandInfo]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByValue)



---
#### **Parameter**

A dictionary of parameters.



> **Type**: ```[IDictionary]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
#### **ArgumentList**

A list of arguments.



> **Type**: ```[PSObject[]]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:false



---
### Syntax
```PowerShell
Inline.TypeScript [-CommandInfo] &lt;CommandInfo&gt; [[-Parameter] &lt;IDictionary&gt;] [[-ArgumentList] &lt;PSObject[]&gt;] [&lt;CommonParameters&gt;]
```
---



