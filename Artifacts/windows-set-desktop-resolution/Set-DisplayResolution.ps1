param(
	[int]$Width,
    [int]$Height
)
if (-not $Width) {
    throw "Parameter '-Width' is required."
}
if (-not $Height) {
    throw "Parameter '-Height' is required."
}

Set-DisplayResolution -Width $Width -Height $Height -Force