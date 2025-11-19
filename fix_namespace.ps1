# Script to fix namespace issue in tflite_flutter_helper_plus
$pluginPath = "$env:LOCALAPPDATA\Pub\Cache\hosted\pub.dev\tflite_flutter_helper_plus-0.0.2\android\build.gradle"

if (Test-Path $pluginPath) {
    $content = Get-Content $pluginPath -Raw
    
    # Check if namespace is already set
    if ($content -notmatch 'namespace\s+"com\.a5starcompany\.tflite_flutter_helper_plus"') {
        # Add namespace if not present
        $content = $content -replace '(android\s+\{)', "`$1`n    namespace `"com.a5starcompany.tflite_flutter_helper_plus`""
        Set-Content -Path $pluginPath -Value $content -NoNewline
        Write-Host "Fixed namespace in $pluginPath"
    } else {
        Write-Host "Namespace already set correctly"
    }
} else {
    Write-Host "Plugin path not found: $pluginPath"
}

