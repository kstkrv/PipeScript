<#
.SYNOPSIS
    Yaml File Transpiler.
.DESCRIPTION
    Transpiles Yaml with Inline PipeScript into Yaml.

    Because Yaml does not support comment blocks, PipeScript can be written inline inside of specialized Yaml string.

    PipeScript can be included in a multiline Yaml string with the Key PipeScript and a Value surrounded by {}    
.Example
    .> {
        $yamlContent = @'
PipeScript: |
  {
    @{a='b'}
  }

List:
  - PipeScript: |
      {
        @{a='b';k2='v';k3=@{k='v'}}
      }
  - PipeScript: |
      {
        @(@{a='b'}, @{c='d'})
      }      
  - PipeScript: |
      {
        @{a='b'}, @{c='d'}
      }
'@
        [OutputFile('.\HelloWorld.ps1.yaml')]$yamlContent
    }

    .> .\HelloWorld.ps1.yaml
#>
[ValidatePattern('\.(?>yml|yaml)$')]
param(
# The command information.  This will include the path to the file.
[Parameter(Mandatory,ValueFromPipeline)]
[Management.Automation.CommandInfo]
$CommandInfo,

# A dictionary of parameters.
[Collections.IDictionary]
$Parameter,

# A list of arguments.
[PSObject[]]
$ArgumentList
)

begin {
    # We start off by declaring a number of regular expressions:    
    
    # Create a splat containing arguments to the core inline transpiler
    $Splat      = [Ordered]@{
        ReplacePattern  = [Regex]::new('        
        (?<Indent>\s{0,})      # Capture the indentation level
        (?<InList>-\s)?        # Determine if we are in a list
        PipeScript              # Then match the key Pipescript
        :\s\|                   # followed by a whitespace and pipe character
        (?>\r\n|\n){1,}         # Match one or more newlines  
        (\k<Indent>)\s{2}       # The ScriptBlock must be indented at least two spaces
        (?(InList)\s{2})        # (four if it is a list)
        \{                      # Then we need to match the opening brace
        (?<PipeScript>          # And we finally start matching our Script
          (?:.|\s){0,}?(?=      # This is zero or more characters until
              \z|               # The end of the string OR
              (\k<Indent>)\s{2} # A Matching pair or quad of indentation.
              (?(InList)\s{2}) 
              \}                # followed by a closing brace.
            )
        )
        (\k<Indent>)\s{2}       # To complete the match, we check indentation once more
        (?(InList)\s{2})
        \}
        ', 'IgnorePatternWhitespace,IgnoreCase')
    }
}

process {
    # Add parameters related to the file
    $Splat.SourceFile = $commandInfo.Source -as [IO.FileInfo]
    $Splat.SourceText = [IO.File]::ReadAllText($commandInfo.Source)
    if ($Parameter) { $splat.Parameter = $Parameter }
    if ($ArgumentList) { $splat.ArgumentList = $ArgumentList }
    $Splat.ForeachObject = {
        begin {
            $yamlOut = [Collections.Queue]::new()
        }
        process {
            $YamlOut.Enqueue($_)
        }
        end {
            if ($yamlOut.Count -eq 1) {
                $yamlOut = $yamlOut[0]
            } else {
                $isList = $true
            }
    
            @(foreach ($yo in $yamlOut) {
                if ($yo -is [string]) {

                }
                if ($yo -is [Collections.IDictionary]) {
                    $yo = [PSCustomObject]$yo
                }
                $yamlObject = [PSCustomObject]::new($yo)
                $yamlObject.pstypenames.clear()
                $yamlObject.pstypenames.add('Yaml')
                $yamlLines  = @((Out-String -InputObject $yamlObject -Width 1kb).Trim() -split '(?>\r\n|\n)')
                $isList     = $yamlLines[0] -match '^-\s'
                $inList     = $match.Groups["InList"].Value -as [bool]
                $yamlIndent = ' ' * ($match.Groups["Indent"].Length -as [int])
                @(for ($yamlLineNumber = 0; $yamlLineNumber -lt $yamlLines.Length; $yamlLineNumber++) {
                    $yamlLine = $yamlLines[$yamlLineNumber]                    
                    $(if ($inList -and -not $isList) {
                        if (-not $yamlLineNumber) {
                            $yamlIndent + '- '
                        } else {
                            $yamlIndent + '  '
                        }
                    } else {
                        $yamlIndent
                    }) + $yamlLine
                }) -join [Environment]::NewLine
            }) -join [Environment]::Newline
        }
    }
    # Call the core inline transpiler.
    .>PipeScript.Inline @Splat
}