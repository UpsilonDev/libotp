# libotp
TOTP/HOTP (soon™) and Yubico OTP library for ComputerCraft

## Security disclaimer
- **No guarantee is given for the security for this library. Use it at your own risk.** It has not gone thru an security audit of any kind. This doesn't mean that the library is unsafe to use!!
- libotp does not store tokens or seeds in any way, shape, or form; it is up to the application utilizing this library to store tokens/seeds in a secure manner.
- libotp utilizes KillaVanilla/Tatantyler's [CSPRNG library](https://pastebin.com/D1th4Htw) for random nonce generation in the Yubico OTP algorithm. This ISAAC implementation has not been thoroughly tested for security flaws.

## Algorithms implemented
- [ ] [Yubico OTP](https://developers.yubico.com/OTP/)
- - [ ] Algorithm
- - [ ] ModHex implementation (in Pure Lua)
- - [ ] Request signing
- [ ] HOTP & TOTP (RFC [4226](https://tools.ietf.org/html/rfc4226), [6238](https://tools.ietf.org/html/rfc6238))
- - [ ] The OTP algorithm itself :shipit:

## Documentation
Coming soon™
