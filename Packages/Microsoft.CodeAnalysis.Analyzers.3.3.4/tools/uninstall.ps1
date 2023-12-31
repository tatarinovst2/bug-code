﻿param($installPath, $toolsPath, $package, $project)

$analyzersDir = Join-Path (Split-Path -Path $toolsPath -Parent) "analyzers"
if (-Not (Test-Path $analyzersDir))
{
    return
}

$analyzersPaths = Join-Path ( $analyzersDir ) * -Resolve

foreach($analyzersPath in $analyzersPaths)
{
    # Uninstall the language agnostic analyzers.
    if (Test-Path $analyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem $analyzersPath -Filter *.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                $project.Object.AnalyzerReferences.Remove($analyzerFilePath.FullName)
            }
        }
    }
}

# $project.Type gives the language name like (C# or VB.NET)
$languageFolder = ""
if($project.Type -eq "C#")
{
    $languageFolder = "cs"
}
if($project.Type -eq "VB.NET")
{
    $languageFolder = "vb"
}
if($languageFolder -eq "")
{
    return
}

foreach($analyzersPath in $analyzersPaths)
{
    # Uninstall language specific analyzers.
    $languageAnalyzersPath = join-path $analyzersPath $languageFolder
    if (Test-Path $languageAnalyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem $languageAnalyzersPath -Filter *.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                try
                {
                    $project.Object.AnalyzerReferences.Remove($analyzerFilePath.FullName)
                }
                catch
                {

                }
            }
        }
    }
}
# SIG # Begin signature block
# MIIojQYJKoZIhvcNAQcCoIIofjCCKHoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCB5mT/HBF+ApGFF
# NurlQsK+/gKFs6a98ziX+/GaLDsVJqCCDfAwggZuMIIEVqADAgECAhMzAAADBU1i
# DWiFB6ozAAAAAAMFMA0GCSqGSIb3DQEBDAUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwODA0MjAyMzU3WhcNMjMwODAzMjAyMzU3WjBjMQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMQ0wCwYDVQQDEwQuTkVU
# MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAuBPUn3y4+hrXB6JCyc4U
# ffIv1VytDkksYhlPnRkUmnhw6lD6Ae1HHFUTz2E+JM/MsBFUdq5tc2h1mwGZaTg9
# tY2Q/CbRoqKzTa43vUVqun065znQ/OfUNP5Hf57dqFcuG0LmaVNoJmIngBTduXJq
# pAsot4lremrIcGcmJfJI0GuEsGSV6C4MuKoEtrOIJZtAsAiUtSXKkj9y60QKsMpT
# j9/s8cz7WBRB0r5Zmcf/63zagBjRVcbelQxnO/dTKw07gJLVoUCNAblyN0m5LzXa
# frnyY5Ig/AXnOZ9ogfXiqH9c/J+LRrpZ1lpkhG2Hd2c/1VwY3WwNK5xFX+ej35pI
# +pbK3X2Kk3iOK4kgtQeGb7d56S3YoZopbKzbCGzATVGQGgCrsaa8Uite9wQHSaoz
# /T1sh+C+SM3nTP/leYyXKuq2YPQV75XUNNt87KF0Fmm3gbZxuord6gVSgkjK2fc3
# TrMgFPSR3wFVYNYo5OLRUexfHxy8cMoMs4vmIrZERyJvAgMBAAGjggF+MIIBejAf
# BgNVHSUEGDAWBgorBgEEAYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUw8YZ5PLP
# dj4XQBBwk4pybOKrVhswUAYDVR0RBEkwR6RFMEMxKTAnBgNVBAsTIE1pY3Jvc29m
# dCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMRYwFAYDVQQFEw00NjQyMjMrNDcyMjM3
# MB8GA1UdIwQYMBaAFEhuZOVQBdOCqhc3NyK1bajKdQKVMFQGA1UdHwRNMEswSaBH
# oEWGQ2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY0NvZFNp
# Z1BDQTIwMTFfMjAxMS0wNy0wOC5jcmwwYQYIKwYBBQUHAQEEVTBTMFEGCCsGAQUF
# BzAChkVodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY0Nv
# ZFNpZ1BDQTIwMTFfMjAxMS0wNy0wOC5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG
# 9w0BAQwFAAOCAgEAaEpKeazIa/JwvoPDi6rfAO3B0z+FJsbpvk2rFS0igT1MxPhS
# qP41a1h+sHT26rw7PGQsedoR5zX3HkTJXHL4MGlubM1Tf/jr2oXiTKnQU2MImWYW
# AWjEs0XOKzEp5NfDWkWmkzkDEcb79Woh1CU4JtzadNIkurFqDgbcn5+wQTq7LDHD
# o3F+J5EHMAl3YcY8tRWm3zsYuSU2OzLENQliTEW2CSPWSEarAgbpk2Rshc+zFHxL
# 2iIqoA/vVxkTA3r5Oec8ii2pd4GwL66sv80Hw1bEER6elUUUXjM1d3exuZvgf/rr
# wMpBog/lCbQiB7aebGBcA+r0I9hlrBc6/E6E4WCJTcC0sUAr85z6yCRcJ4tfYDpE
# qrxKqDAfC2NZdq+LIROgMXBIx16X7L73BJmiRcHCv7tOMYu5GKed1QaOJW0lT+uz
# P/L3ELlOI6foECPBcHQSS2gzR09xO7d30ALSraDKUTBM8B19JukAEb4g8cSC06gP
# FIHFQZyF0QSXKSVzDPoLygZJdHoJUYdXtBb5wfTcL0MfucEGECFQiiOoJjApv1vw
# ZqbbluutQXB/y2jl1ctnXgdh5ED1zoAfYIHCITgAE+k6r+LKkZaKXxXKDdR/ouaA
# AQwzFlgu02DkZsze1xNbYzcLQRkUimK5PjeG+by40elcBk/c8nfIJznJHT0wggd6
# MIIFYqADAgECAgphDpDSAAAAAAADMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQg
# Um9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAxMTAeFw0xMTA3MDgyMDU5MDla
# Fw0yNjA3MDgyMTA5MDlaMH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTEw
# ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCr8PpyEBwurdhuqoIQTTS6
# 8rZYIZ9CGypr6VpQqrgGOBoESbp/wwwe3TdrxhLYC/A4wpkGsMg51QEUMULTiQ15
# ZId+lGAkbK+eSZzpaF7S35tTsgosw6/ZqSuuegmv15ZZymAaBelmdugyUiYSL+er
# CFDPs0S3XdjELgN1q2jzy23zOlyhFvRGuuA4ZKxuZDV4pqBjDy3TQJP4494HDdVc
# eaVJKecNvqATd76UPe/74ytaEB9NViiienLgEjq3SV7Y7e1DkYPZe7J7hhvZPrGM
# XeiJT4Qa8qEvWeSQOy2uM1jFtz7+MtOzAz2xsq+SOH7SnYAs9U5WkSE1JcM5bmR/
# U7qcD60ZI4TL9LoDho33X/DQUr+MlIe8wCF0JV8YKLbMJyg4JZg5SjbPfLGSrhwj
# p6lm7GEfauEoSZ1fiOIlXdMhSz5SxLVXPyQD8NF6Wy/VI+NwXQ9RRnez+ADhvKwC
# gl/bwBWzvRvUVUvnOaEP6SNJvBi4RHxF5MHDcnrgcuck379GmcXvwhxX24ON7E1J
# MKerjt/sW5+v/N2wZuLBl4F77dbtS+dJKacTKKanfWeA5opieF+yL4TXV5xcv3co
# KPHtbcMojyyPQDdPweGFRInECUzF1KVDL3SV9274eCBYLBNdYJWaPk8zhNqwiBfe
# nk70lrC8RqBsmNLg1oiMCwIDAQABo4IB7TCCAekwEAYJKwYBBAGCNxUBBAMCAQAw
# HQYDVR0OBBYEFEhuZOVQBdOCqhc3NyK1bajKdQKVMBkGCSsGAQQBgjcUAgQMHgoA
# UwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQY
# MBaAFHItOgIxkEO5FAVO4eqnxzHRI4k0MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6
# Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1
# dDIwMTFfMjAxMV8wM18yMi5jcmwwXgYIKwYBBQUHAQEEUjBQME4GCCsGAQUFBzAC
# hkJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1
# dDIwMTFfMjAxMV8wM18yMi5jcnQwgZ8GA1UdIASBlzCBlDCBkQYJKwYBBAGCNy4D
# MIGDMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3Bz
# L2RvY3MvcHJpbWFyeWNwcy5odG0wQAYIKwYBBQUHAgIwNB4yIB0ATABlAGcAYQBs
# AF8AcABvAGwAaQBjAHkAXwBzAHQAYQB0AGUAbQBlAG4AdAAuIB0wDQYJKoZIhvcN
# AQELBQADggIBAGfyhqWY4FR5Gi7T2HRnIpsLlhHhY5KZQpZ90nkMkMFlXy4sPvjD
# ctFtg/6+P+gKyju/R6mj82nbY78iNaWXXWWEkH2LRlBV2AySfNIaSxzzPEKLUtCw
# /WvjPgcuKZvmPRul1LUdd5Q54ulkyUQ9eHoj8xN9ppB0g430yyYCRirCihC7pKkF
# DJvtaPpoLpWgKj8qa1hJYx8JaW5amJbkg/TAj/NGK978O9C9Ne9uJa7lryft0N3z
# Dq+ZKJeYTQ49C/IIidYfwzIY4vDFLc5bnrRJOQrGCsLGra7lstnbFYhRRVg4MnEn
# Gn+x9Cf43iw6IGmYslmJaG5vp7d0w0AFBqYBKig+gj8TTWYLwLNN9eGPfxxvFX1F
# p3blQCplo8NdUmKGwx1jNpeG39rz+PIWoZon4c2ll9DuXWNB41sHnIc+BncG0Qax
# dR8UvmFhtfDcxhsEvt9Bxw4o7t5lL+yX9qFcltgA1qFGvVnzl6UJS0gQmYAf0AAp
# xbGbpT9Fdx41xtKiop96eiL6SJUfq/tHI4D1nvi/a7dLl+LrdXga7Oo3mXkYS//W
# syNodeav+vyL6wuA6mk7r/ww7QRMjt/fdW1jkT3RnVZOT7+AVyKheBEyIXrvQQqx
# P/uozKRdwaGIm1dxVk5IRcBCyZt2WwqASGv9eZ/BvW1taslScxMNelDNMYIZ8zCC
# Ge8CAQEwgZUwfjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEo
# MCYGA1UEAxMfTWljcm9zb2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMQITMwAAAwVN
# Yg1ohQeqMwAAAAADBTANBglghkgBZQMEAgEFAKCBrjAZBgkqhkiG9w0BCQMxDAYK
# KwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG
# 9w0BCQQxIgQgu0R4wRR6xdzJye8AHTQLWb7VeQRxQGN+E0g3YhmB+RkwQgYKKwYB
# BAGCNwIBDDE0MDKgFIASAE0AaQBjAHIAbwBzAG8AZgB0oRqAGGh0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbTANBgkqhkiG9w0BAQEFAASCAYAehn7OSe0/iBYDHNKVUzYi
# adEVVmDjP934lwYokRi6sylzt2f8PgJpZYxa6c/wLHYtoDx0jh8pm1Kp0so9Hwrq
# dPXzGqVqTlxKoWIxAZVuIrXHzpYAoE5RceUPfGRe+FzMktNIIPbgWJ/K0wWGAQzm
# 9TRQN2TkaeePHgIu/Eon7RTDLcqUwFB/uNqt0mLWeIQu/4UICjwGA3eL2FbeXjJK
# OG6Qito8h4McFznxlqRqQsueFfbsCN+7EP/DANFg3+n6EWvF8exjkTKEa8jwef24
# P+jMrJQznrm/24UUQ/0nl389gRN6iElyvOzcv0z+Dcf1z62TLYs4WULWkEQpU9E7
# tdoCE6JEkl+DnMmUyWRH+TYnw4DH9TaBrFiUGxF5UJ3UeXBwQa0sB/y3s1zm3/gd
# 7OaatAXrw/ia0FRHgeHhpFXJVobeQVME0cp+r5FJyw5ZwIexXVikTC8gUSP9EpQc
# Eyp11Sged5zbwmYTCFkQCJjXVRtnxJJ2Zp/G3Jw7FSqhghb9MIIW+QYKKwYBBAGC
# NwMDATGCFukwghblBgkqhkiG9w0BBwKgghbWMIIW0gIBAzEPMA0GCWCGSAFlAwQC
# AQUAMIIBUQYLKoZIhvcNAQkQAQSgggFABIIBPDCCATgCAQEGCisGAQQBhFkKAwEw
# MTANBglghkgBZQMEAgEFAAQgHwzzL7JJyiGoS7niWGSR16ojDFbjcwzxMVl/L82g
# FbkCBmO/8MyGhhgTMjAyMzAxMTcxMzExMDYuOTIxWjAEgAIB9KCB0KSBzTCByjEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjElMCMGA1UECxMcTWlj
# cm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEmMCQGA1UECxMdVGhhbGVzIFRTUyBF
# U046MjI2NC1FMzNFLTc4MEMxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFNlcnZpY2WgghFUMIIHDDCCBPSgAwIBAgITMwAAAcE+oIOc4AmvxQABAAABwTAN
# BgkqhkiG9w0BAQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3Rv
# bjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0
# aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0y
# MjExMDQxOTAxMjdaFw0yNDAyMDIxOTAxMjdaMIHKMQswCQYDVQQGEwJVUzETMBEG
# A1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWlj
# cm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBP
# cGVyYXRpb25zMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjoyMjY0LUUzM0UtNzgw
# QzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCCAiIwDQYJ
# KoZIhvcNAQEBBQADggIPADCCAgoCggIBAOSx1zMncNoVAuKSVNCObjyZzHkZvCyg
# uMWiA7txccdyKWf1ntqly4+DTpqMP1jxXmOL2k+P0uE/caA7BRoOcBCTOji2VX2u
# wVDbtLQ7eK5Je0AWDR88+qXK/W8Gqtqpu8ej/couVtGPLI6I/kE4LZpl6MQqDV4S
# daBuhm6gA0Fw2ZE3A4yAIrXhOk8a4QaSG+3urqYn0xmTX3AoT37sx6utRUiMCdFw
# sXGkdQcAJUioW/zVDrkBj6/Wc3ejpyHAPkXLccCoHzigfWlhBB5bdI4SioKRAb3C
# ZzDD/lmk8JjIaG9XvoaAhBcf5yNGB7qYutPNpBXTRa2hO9prDmEK8K1Mlgnkpjdt
# Ni2Q6U88WVbcukKwTpPn/gRK7EfjOXr5CrlE1lSRyN77TYG+iufoJOhLkMNKHLA3
# bKYj6fqpcQWludMlG6+sJ382IyYe0JD3HwSGWyQIVkB2ldLkt0+zpDm3QrLAkTFh
# +1VlAHkm3prlKjlwke63aRU32P0lyjvZQiEAQEEofsM8IeWb9W/o09s1sFZfNgct
# 2B5kk/G/Aip0V0goy7YKMsuxES8JG8zyJAnwV3MlZ3gtcNv8FJ6j4gIytMEH87X1
# xX6DEK/GFHCx5wLXpPDlTT7kSFem3BEWxeq7RV5p44w+GcFcSGfxzOHI3lRrBMJB
# QPV086l/VtT/AgMBAAGjggE2MIIBMjAdBgNVHQ4EFgQUX69jCese8hPoD+bl/cVh
# k8KUQvowHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYDVR0fBFgw
# VjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvTWlj
# cm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwGCCsGAQUF
# BwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Br
# aW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIwMjAxMCgx
# KS5jcnQwDAYDVR0TAQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcDCDANBgkqhkiG
# 9w0BAQsFAAOCAgEAX7omgYLHnB7zPdEWYkw5Xx25S9Pa/V/uavXJLjEdAbNUq+Qd
# jAC4U+WNEd4IC7n0V+kUEG0nO1sUVyDK+bRRIAec8v+2IPNQp9nYU39Rs4wm+/59
# 8LSUhra9kMB7GtXoWFnTH4vhEy6BF9Ru/VTxa7NLehosKa++Lb/gixN7OptdFTsH
# vNMD+Mrk93ohX6kVfKaFBUnS9sHJYECqEsGwqWyZTQvxEmg0G20BZYvbjuY9n/xu
# 0uEzBv4MssbzEOUCbovRcNrO6pJZqM0KF9gIeGirmynvf1Wb3ohEzWJdQGT49JI9
# YOdVTclo7x8Ph89cWXpFiKXzF0BItMKxnVnoluIvJfdq2N2W3R7BKxWKs4ehURTn
# l4GszbH5C5sMvkyte5gOwkxFM2gFjKufn/SuGP95oQeK+lK4rLZFqXZD1hKPG/bW
# 5HSkmNNBPhUuQ1LY4AHQmkQTWgbvHBWAmxK4fa6Fg8XPiLL/MjEAFA7hMF0stBMZ
# yAJXFSK4cy+NDrBtnGuUeQYAHrxj9R4/Xo+Jf8vkodB1XDfTei5jw5iPzGlNqxGe
# 2Po0XwmdXfpeQxEnS1yMQ08rGF5E/t1TP9c4estrNGbG/97z2hp6ds3o8H9mJRlp
# dV6QoTWU3pReXjggn0s1FJ96h3uyMsgyoWoYG5yqZsHBJDFQbPkR21ZDVqgwggdx
# MIIFWaADAgECAhMzAAAAFcXna54Cm0mZAAAAAAAVMA0GCSqGSIb3DQEBCwUAMIGI
# MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVk
# bW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIwMAYDVQQDEylN
# aWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAxMDAeFw0yMTA5
# MzAxODIyMjVaFw0zMDA5MzAxODMyMjVaMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBD
# QSAyMDEwMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5OGmTOe0ciEL
# eaLL1yR5vQ7VgtP97pwHB9KpbE51yMo1V/YBf2xK4OK9uT4XYDP/XE/HZveVU3Fa
# 4n5KWv64NmeFRiMMtY0Tz3cywBAY6GB9alKDRLemjkZrBxTzxXb1hlDcwUTIcVxR
# MTegCjhuje3XD9gmU3w5YQJ6xKr9cmmvHaus9ja+NSZk2pg7uhp7M62AW36MEByd
# Uv626GIl3GoPz130/o5Tz9bshVZN7928jaTjkY+yOSxRnOlwaQ3KNi1wjjHINSi9
# 47SHJMPgyY9+tVSP3PoFVZhtaDuaRr3tpK56KTesy+uDRedGbsoy1cCGMFxPLOJi
# ss254o2I5JasAUq7vnGpF1tnYN74kpEeHT39IM9zfUGaRnXNxF803RKJ1v2lIH1+
# /NmeRd+2ci/bfV+AutuqfjbsNkz2K26oElHovwUDo9Fzpk03dJQcNIIP8BDyt0cY
# 7afomXw/TNuvXsLz1dhzPUNOwTM5TI4CvEJoLhDqhFFG4tG9ahhaYQFzymeiXtco
# dgLiMxhy16cg8ML6EgrXY28MyTZki1ugpoMhXV8wdJGUlNi5UPkLiWHzNgY1GIRH
# 29wb0f2y1BzFa/ZcUlFdEtsluq9QBXpsxREdcu+N+VLEhReTwDwV2xo3xwgVGD94
# q0W29R6HXtqPnhZyacaue7e3PmriLq0CAwEAAaOCAd0wggHZMBIGCSsGAQQBgjcV
# AQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFCqnUv5kxJq+gpE8RjUpzxD/LwTuMB0G
# A1UdDgQWBBSfpxVdAF5iXYP05dJlpxtTNRnpcjBcBgNVHSAEVTBTMFEGDCsGAQQB
# gjdMg30BATBBMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20v
# cGtpb3BzL0RvY3MvUmVwb3NpdG9yeS5odG0wEwYDVR0lBAwwCgYIKwYBBQUHAwgw
# GQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB
# /wQFMAMBAf8wHwYDVR0jBBgwFoAU1fZWy4/oolxiaNE9lJBb186aGMQwVgYDVR0f
# BE8wTTBLoEmgR4ZFaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJv
# ZHVjdHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsGAQUFBwEBBE4w
# TDBKBggrBgEFBQcwAoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0
# cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcnQwDQYJKoZIhvcNAQELBQADggIB
# AJ1VffwqreEsH2cBMSRb4Z5yS/ypb+pcFLY+TkdkeLEGk5c9MTO1OdfCcTY/2mRs
# fNB1OW27DzHkwo/7bNGhlBgi7ulmZzpTTd2YurYeeNg2LpypglYAA7AFvonoaeC6
# Ce5732pvvinLbtg/SHUB2RjebYIM9W0jVOR4U3UkV7ndn/OOPcbzaN9l9qRWqveV
# tihVJ9AkvUCgvxm2EhIRXT0n4ECWOKz3+SmJw7wXsFSFQrP8DJ6LGYnn8AtqgcKB
# GUIZUnWKNsIdw2FzLixre24/LAl4FOmRsqlb30mjdAy87JGA0j3mSj5mO0+7hvoy
# GtmW9I/2kQH2zsZ0/fZMcm8Qq3UwxTSwethQ/gpY3UA8x1RtnWN0SCyxTkctwRQE
# cb9k+SS+c23Kjgm9swFXSVRk2XPXfx5bRAGOWhmRaw2fpCjcZxkoJLo4S5pu+yFU
# a2pFEUep8beuyOiJXk+d0tBMdrVXVAmxaQFEfnyhYWxz/gq77EFmPWn9y8FBSX5+
# k77L+DvktxW/tM4+pTFRhLy/AsGConsXHRWJjXD+57XQKBqJC4822rpM+Zv/Cuk0
# +CQ1ZyvgDbjmjJnW4SLq8CdCPSWU5nR0W2rRnj7tfqAxM328y+l7vzhwRNGQ8cir
# Ooo6CGJ/2XBjU02N7oJtpQUQwXEGahC0HVUzWLOhcGbyoYICyzCCAjQCAQEwgfih
# gdCkgc0wgcoxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYD
# VQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJTAj
# BgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMxJjAkBgNVBAsTHVRo
# YWxlcyBUU1MgRVNOOjIyNjQtRTMzRS03ODBDMSUwIwYDVQQDExxNaWNyb3NvZnQg
# VGltZS1TdGFtcCBTZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQBEijrUiu0VVSvkovmq
# hXdGEmPlT6CBgzCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMA0G
# CSqGSIb3DQEBBQUAAgUA53EGpzAiGA8yMDIzMDExNzE5MzYwN1oYDzIwMjMwMTE4
# MTkzNjA3WjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDncQanAgEAMAcCAQACAgzL
# MAcCAQACAhGiMAoCBQDnclgnAgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQB
# hFkKAwKgCjAIAgEAAgMHoSChCjAIAgEAAgMBhqAwDQYJKoZIhvcNAQEFBQADgYEA
# jpOIp8g7WFq5r4v0IHEPL0ppuHbqDP0Y6wN5Au0aM4KBu5/JSTk2jzH++VtLmTGD
# spP3Z5SbMPrM1JJf2SJ3Yo9TUCdYcENkXnwXC7qKAFbv3TTmAg7aH7xx/5n+OHEz
# LeRXI/mnBikuq3Rrdvm36XhuobyktPG7+CbkAnhG73sxggQNMIIECQIBATCBkzB8
# MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVk
# bW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1N
# aWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAcE+oIOc4AmvxQABAAAB
# wTANBglghkgBZQMEAgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEE
# MC8GCSqGSIb3DQEJBDEiBCBKGkM9ccZVrbNYHONE1LRlleOAdjtIdFMdunR0Qv3P
# kzCB+gYLKoZIhvcNAQkQAi8xgeowgecwgeQwgb0EIAq5IOrYGB3koCLDd6KUds+x
# BMVgNGJIq5L1WEkwYHbUMIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENB
# IDIwMTACEzMAAAHBPqCDnOAJr8UAAQAAAcEwIgQg5wthsbOLwEwN+ZLaL2JzGJKk
# 8ur3WKcAW0ZCkzkAwlAwDQYJKoZIhvcNAQELBQAEggIATeDZEhlQAY2aIh/PmYwM
# JDHdnOEFSpo8Qh+gKNKnVIYdDPFTv8C3bJbYcpqE0RAvfsGoXqOwrj4rxHfsAkt1
# JPmfUkryNg7S7+dlhxFRsuOcx95aRVQ/gHPF08VjICN4t+PUrTwhNyZqxNGAdvEG
# OpBL1Ih3Nlu49HPuYegsILDGg2gqNfwfOT+91sBARHf4fD3IQtmMuK0zSpzwaU3B
# Dn75mkm0/V1gOEf9F1jaKsW6ukc/R7I5+WCRYMAJpDIHab0b4yJC9wLnPtq+Kps5
# MubU1RMOgCFjld4iUl7Caz8NFRYJ+PvDsOJIOj6/u8JlfXu+Ez+2gb/AiwWCswHc
# 9ZZ+X0tVjCYgIMl15Wa3u4sL1T/woqSPnoKUXjkYvxXK02Gy1qE8YBkikEdNlKfk
# r632fG8ptq4cuBJJyKuoHKpXr/qeYVOYqlr1NMqgGL/nxYpmqxWFhe6d5350bOyh
# f/KwOjZsGYvf3Y1VNFSHEX/5DCpGYPukLRR41YPOng8GeYpctIVYHZWpvvc8o0Dm
# XifmAeRoeqhOp//niUNIXwbt4PKlJVYyOZAGoXXxOb4sw1KVM7WxISVYpYt4gSRm
# 5nOtylM0n+J6PIHG9AyBVKTdYMt19Hnyfm2scnST74jlJU2g8W6GdOYia8p4B7nE
# NKWma+cbkGw+7219NQirfP0=
# SIG # End signature block
