$projectName = Read-Host "Project Name: "
$templateType = Read-Host "Template type (bootstrap, tailwind)"
$projectType = Read-Host "Send to GitHub? [Yes/No]"
if ($projectType -eq "Yes") {
    $repoVisibility = Read-Host "Private or Public repo? [private/public]"
    gh repo create $projectName --visibility $repoVisibility --confirm
    git clone https://github.com/Blake14/$projectName
}

New-Item -Path ./$projectName -Type Directory
Set-Location $projectName

npx create-react-app client
Set-Location client
Remove-Item src/logo.svg, src/App.test.js, src/reportWebVitals.js, src/setupTests.js, src/app.css, src/index.css

Copy-Item "../../templates/reactjs/App.js" -Destination "src/App.js" -Force
Copy-Item "../../templates/reactjs/Index.js" -Destination "src/index.js" -Force 
Copy-Item "../../templates/reactjs/tailwind.css" -Destination "src/styles/tailwind.css" -Force 

switch ($templateType) {
    "tailwind" {
        yarn add tailwindcss@npm:@tailwindcss/postcss7-compat @tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9 react-bootstrap bootstrap react-icons react-bootstrap-icons react-router-dom
    }
    "bootstrap" {
        yarn add react-bootstrap bootstrap react-icons react-bootstrap-icons react-router-dom
    }
}
if ($projectType -eq "Yes") {
    git add .
    git commit -m "Initial commit with template setup"
    git push origin main
}