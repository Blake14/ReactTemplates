# Ask for user input
$projectName = Read-Host "Enter the project name"
$repoVisibility = Read-Host "Private or Public repo? [private/public]"
$templateType = Read-Host "Template type (bootstrap, tailwind)"


# Create GitHub repository
gh repo create $projectName --$repoVisibility --confirm
# Clone the repo locally
git clone https://github.com/Blake14/$projectName
New-Item -Path ./$projectName -type Directory
Set-Location $projectName

npx create-react-app client
Set-Location client

# Remove unwanted files
Remove-Item src/logo.svg, src/App.test.js, src/reportWebVitals.js, src/setupTests.js

# Replace App.js with a template file based on selected template
if ($templateType -eq "bootstrap") {
    Copy-Item "../../templates/reactjs/App.js" -Destination "src/App.js" -Force
}

# Add necessary dependencies
switch ($templateType) {
    "tailwind" {
        yarn add react, react-bootstrap, react-bootstrap, react-icons, tailwindcss@npm:@tailwindcss/postcss7-compat @tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9
    }
    "bootstrap" {
        yarn add react, react-bootstrap, react-bootstrap, react-icons
    }
}

# Initialize git and first commit
git add .
git commit -m "Initial commit with template setup"
git push origin main