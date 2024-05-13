# Ask for user input
$projectName = Read-Host "Enter the project name"
$repoVisibility = Read-Host "Private or Public repo? [private/public]"
$templateType = Read-Host "Template type (React-Bootstrap, React-Tailwind)"


# Create GitHub repository
gh repo create $projectName --$repoVisibility --confirm
# Clone the repo locally
git clone https://github.com/Blake14/$projectName

Set-Location $projectName

npx create-react-app client
Set-Location client

# Remove unwanted files
Remove-Item src/logo.svg, src/App.test.js, src/reportWebVitals.js, src/setupTests.js

# Replace App.js with a template file based on selected template
if ($templateType -eq "React-Bootstrap") {
    Copy-Item "../templates/reactjs/App.js" -Destination "src/App.js" -Force
}

# Add necessary dependencies
switch ($templateType) {
    "Tailwind" {
        yarn add react, react-bootstrap, react-bootstrap, react-icons, tailwindcss@npm:@tailwindcss/postcss7-compat @tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9
    }
    "Bootstrap" {
        yarn add react, react-bootstrap, react-bootstrap, react-icons
    }
}

# Initialize git and first commit
git add .
git commit -m "Initial commit with template setup"
git push origin main