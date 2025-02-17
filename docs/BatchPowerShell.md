
BatchPowerShell
---------------
### Synopsis
Wraps PowerShell in a Windows Batch Script

---
### Description

Wraps PowerShell in a Windows Batch Script

---
### Parameters
#### **ScriptInfo**

> **Type**: ```[ExternalScriptInfo]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByValue)



---
#### **ScriptBlock**

> **Type**: ```[ScriptBlock]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByValue)



---
#### **Pwsh**

If set, will use PowerShell core (pwsh.exe).  If not, will use Windows PowerShell (powershell.exe)



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Syntax
```PowerShell
BatchPowerShell -ScriptInfo &lt;ExternalScriptInfo&gt; [-Pwsh] [&lt;CommonParameters&gt;]
```
```PowerShell
BatchPowerShell -ScriptBlock &lt;ScriptBlock&gt; [-Pwsh] [&lt;CommonParameters&gt;]
```
---



