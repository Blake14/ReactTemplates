# Ask for user input
$projectName = Read-Host "Enter the project name"
$repoVisibility = Read-Host "Private or Public repo? [private/public]"
$templateType = Read-Host "Template type (ReactJS, Bootstrap, Tailwind, etc.)"


Write-Host $projectName