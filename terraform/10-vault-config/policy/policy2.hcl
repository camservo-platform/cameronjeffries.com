path "transit/encrypt/dummypayment" {
    capabilities = ["update"]
}

path "transit/decrypt/dummypayment" {
    capabilities = ["update"]
}

path "transit/*" {
    capabilities = ["list"]
}