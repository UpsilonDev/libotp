# libotp

TOTP/HOTP (soon™) and Yubico OTP library for ComputerCraft

## Security disclaimer

- **No guarantee is given for the security of this library. Use it at your own risk.** It has not gone thru an security audit of any kind. This doesn't mean that the library is unsafe to use!!
- libotp does not store tokens or seeds in any way, shape, or form; it is up to the application utilizing this library to store tokens/seeds in a secure manner.
- libotp utilizes KillaVanilla/Tatantyler's [CSPRNG library](https://pastebin.com/D1th4Htw) for random nonce generation in the Yubico OTP algorithm. This ISAAC implementation has not been thoroughly tested for security flaws.

## To do

- [x] Implement [Yubico OTP](https://developers.yubico.com/OTP/)
  - [x] Algorithm
  - [x] ModHex implementation (in Pure Lua)
  - [ ] CRC checksum validation
  - [x] Request signing and validation
  - [ ] Strict mode for validating OTPs client-side
  - [x] Parallel HTTP requests (toggleable)
- [x] Implement HOTP & TOTP (RFC [4226](https://tools.ietf.org/html/rfc4226), [6238](https://tools.ietf.org/html/rfc6238))
  - [x] The OTP algorithm itself :shipit:
  - [x] Base32 seed generation
  - [x] SHA-1 (required for basic functionality)
  - [x] 7-10 digit codes
  - [x] Skew/look-ahead
- [ ] Documentation
- [x] Howl build system

## Documentation

Coming soon™

## Acknowledgements

- KillaVanilla/Tatantyler for their [CSPRNG](https://pastebin.com/D1th4Htw) library
- SquidDev for their [Howl build system](https://github.com/SquidDev-CC/Howl)
- Anavrins for their [SHA-1](https://pastebin.com/SfL7vxP3) library
- aiq for their [BaseXX](https://github.com/aiq/basexx) library
