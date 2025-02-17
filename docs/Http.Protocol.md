
Http.Protocol
-------------
### Synopsis
http protocol

---
### Description

Converts an http[s] protocol command to PowerShell.

---
### Examples
#### EXAMPLE 1
```PowerShell
{
    https://api.github.com/repos/StartAutomating/PipeScript
}
```

#### EXAMPLE 2
```PowerShell
{
    get https://api.github.com/repos/StartAutomating/PipeScript
} | .&gt;PipeScript
```

#### EXAMPLE 3
```PowerShell
Invoke-PipeScript {
    $GitHubApi = &#39;api.github.com&#39;
    $UserName  = &#39;StartAutomating&#39;
    https://$GitHubApi/users/$UserName
}
```

#### EXAMPLE 4
```PowerShell
-ScriptBlock {
    https://$GitHubApi/users/$UserName -GitHubApi api.github.com -UserName StartAutomating
}
```

#### EXAMPLE 5
```PowerShell
-ScriptBlock {
    https://$GitHubApi/users/$UserName -GitHubApi api.github.com -UserName StartAutomating
}
```

#### EXAMPLE 6
```PowerShell
-ScriptBlock {
    @(foreach ($repo in https://api.github.com/users/StartAutomating/repos?per_page=100) {
        $repo | .Name .Stars { $_.stargazers_count }
    }) | Sort-Object Stars -Descending
}
```

#### EXAMPLE 7
```PowerShell
{
    http://text-processing.com/api/sentiment/ -Method POST -ContentType &#39;application/x-www-form-urlencoded&#39; -Body &quot;text=amazing!&quot; |
        Select-Object -ExpandProperty Probability -Property Label
}
```

---
### Parameters
#### **CommandUri**

The URI.



> **Type**: ```[Uri]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByValue)



---
#### **CommandAst**

The Command's Abstract Syntax Tree



> **Type**: ```[CommandAst]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:false



---
#### **Method**

> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:false



---
### Syntax
```PowerShell
Http.Protocol [-CommandUri] &lt;Uri&gt; [-CommandAst] &lt;CommandAst&gt; [[-Method] &lt;String&gt;] [&lt;CommonParameters&gt;]
```
---



