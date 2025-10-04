Get-ChildItem -Recurse | 
  Select-Object FullName, Length, LastWriteTime |
  Sort-Object FullName |
  Format-Table -AutoSize | Out-String -Width 4096 |
  Out-File -Encoding utf8 ".\_TreeReport.txt"