Param(
    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [string]$Repository#,

    # [Parameter(Mandatory=$True)]
    # [ValidateNotNullOrEmpty()]
    # [string]$Username,

    # [Parameter(Mandatory=$true)]
    # [ValidateNotNullOrEmpty()]
    # [SecureString]$Password
)

function get-randomString {
    $result = 1..10 |
    ForEach-Object{
        $generator = Get-Random -Minimum 97 -Maximum 123
        [char][byte]$generator
    }
    $result -join ''
}

$folderName = get-randomString
Write-Host "Creating folder $folderName.."
mkdir $folderName
Start-Sleep -s 3
cd $folderName
git init
Start-Sleep -s 3
Write-Host "Attempting to pull repository.."
try {
    git pull $Repository
    Start-Sleep -s 3
    Write-Host "Successfully pulled repository"
    $fileName = get-randomString
    $fileName = $fileName + ".md"
    Write-Host "About to create file $fileName.."
    echo "Made with :heart: by PowerContribution" >> $fileName
    Write-Host "$fileName created"
    Start-Sleep 3
    git add .
    git commit -m "created $fileName.md"
    Start-Sleep 3
    git push --set-upstream $Repository master
    Write-Host "Pushed to repository successfully"
    Start-Sleep 3
    rm $fileName
    Write-Host "Removing created file.."
    Start-Sleep 3
    git add .
    Start-Sleep 1
    git commit -m "removing $filename"
    Start-Sleep 3
    git push 
    Start-Sleep 3
}
catch {
    Write-Host "An error occurred:"
    Write-Host $_
    Write-Host "Please check repository exists and you are connected to the internet"
}
finally{
    Write-Host "Deleting local folder"
    cd ..
    Write-Host "Removing folder $folderName.."
    Start-Sleep 3
    rmdir -Force -Recurse $folderName
    Write-Host "All clean!"
}

