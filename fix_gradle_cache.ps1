# Script to fix Gradle cache corruption
Write-Host "Clearing Gradle caches..."

# Clear the specific corrupted cache directory
$cachePath = "$env:USERPROFILE\.gradle\caches\8.12\kotlin-dsl"
if (Test-Path $cachePath) {
    Remove-Item -Path $cachePath -Recurse -Force
    Write-Host "Cleared Kotlin DSL cache"
}

# Clear all Gradle 8.12 caches
$gradleCache812 = "$env:USERPROFILE\.gradle\caches\8.12"
if (Test-Path $gradleCache812) {
    Remove-Item -Path $gradleCache812 -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Cleared Gradle 8.12 cache"
}

# Clear project-level Gradle cache
if (Test-Path "android\.gradle") {
    Remove-Item -Path "android\.gradle" -Recurse -Force
    Write-Host "Cleared project Gradle cache"
}

Write-Host "Done! Now try: flutter clean && flutter pub get && flutter run"





