import base

type
    CFStringEncoding* = distinct uint32

const
    kCFStringEncodingInvalidId* = CFStringEncoding(0xffffffff'u32)
    kCFStringEncodingMacRoman* = CFStringEncoding(0'u32)
    kCFStringEncodingWindowsLatin1* = CFStringEncoding(0x0500'u32)
    kCFStringEncodingISOLatin1* = CFStringEncoding(0x0201'u32)
    kCFStringEncodingNextStepLatin* = CFStringEncoding(0x0B01'u32)
    kCFStringEncodingASCII* = CFStringEncoding(0x0600'u32)
    kCFStringEncodingUnicode* = CFStringEncoding(0x0100'u32)
    kCFStringEncodingUTF8* = CFStringEncoding(0x08000100'u32)
    kCFStringEncodingNonLossyASCII* = CFStringEncoding(0x0BFF'u32)

    kCFStringEncodingUTF16* = CFStringEncoding(0x0100'u32)
    kCFStringEncodingUTF16BE* = CFStringEncoding(0x10000100'u32)
    kCFStringEncodingUTF16LE* = CFStringEncoding(0x14000100'u32)

    kCFStringEncodingUTF32* = CFStringEncoding(0x0c000100'u32)
    kCFStringEncodingUTF32BE* = CFStringEncoding(0x18000100'u32)
    kCFStringEncodingUTF32LE* = CFStringEncoding(0x1c000100'u32)

proc CFStringGetTypeID*(): CFTypeID {.importc.}

proc CFStringCreateWithCString*(alloc: CFAllocatorRef, cStr: cstring, encoding: CFStringEncoding): CFStringRef {.importc.}
proc CFStringCreateWithBytes*(alloc: CFAllocatorRef, bytes: pointer, numBytes: CFIndex, encoding: CFStringEncoding, isExternalRepresentation: Boolean): CFStringRef {.importc.}
proc CFStringCreateWithCharacters*(alloc: CFAllocatorRef, chars: ptr UniChar, numChars: CFIndex): CFStringRef {.importc.}

proc CFStringCreate*(cStr: cstring, encoding: CFStringEncoding): CFStringRef {.inline.} = CFStringCreateWithCString(kCFAllocatorDefault, cStr, encoding)
proc CFStringCreate*(bytes: pointer, numBytes: CFIndex, encoding: CFStringEncoding, isExternalRepresentation: bool): CFStringRef {.inline.} = CFStringCreateWithBytes(kCFAllocatorDefault, bytes, numBytes, encoding, toBoolean(isExternalRepresentation))
proc CFStringCreate*(chars: ptr UniChar, numChars: CFIndex): CFStringRef {.inline.} = CFStringCreateWithCharacters(kCFAllocatorDefault, chars, numChars)
proc CFStringCreate*(s: string): CFStringRef {.inline.} = CFStringCreate(s, kCFStringEncodingUTF8)

proc CFStringCreateWithCStringNoCopy*(alloc: CFAllocatorRef, cStr: cstring, encoding: CFStringEncoding, contentsDeallocator: CFAllocatorRef): CFStringRef {.importc.}
proc CFStringCreateWithBytesNoCopy*(alloc: CFAllocatorRef, bytes: pointer, numBytes: CFIndex, encoding: CFStringEncoding, isExternalRepresentation: Boolean, contentsDeallocator: CFAllocatorRef): CFStringRef {.importc.}
proc CFStringCreateWithCharactersNoCopy*(alloc: CFAllocatorRef, chars: ptr UniChar, numChars: CFIndex, contentsDeallocator: CFAllocatorRef): CFStringRef {.importc.}

proc CFStringCreateWithSubstring*(alloc: CFAllocatorRef, str: CFStringRef, rng: CFRange): CFStringRef {.importc.}
proc CFStringCreateCopy*(alloc: CFAllocatorRef, theString: CFStringRef): CFStringRef {.importc.}

proc CFStringCreateMutable*(alloc: CFAllocatorRef, maxLength: CFIndex): CFMutableStringRef {.importc.}
proc CFStringCreateMutableCopy*(alloc: CFAllocatorRef, maxLength: CFIndex, theString: CFStringRef): CFMutableStringRef {.importc.}

proc len*(theString: CFStringRef): CFIndex {.importc: "CFStringGetLength".}

proc getCharacterAtIndex*(theString: CFStringRef, idx: CFIndex): UniChar {.importc: "CFStringGetCharacterAtIndex".}
proc getCharacters*(theString: CFStringRef, rng: CFRange, buffer: ptr UniChar): UniChar {.importc: "CFStringGetCharacters".}

proc getCString*(theString: CFStringRef, buffer: cstring, bufferSize: CFIndex, encoding: CFStringEncoding): Boolean {.importc: "CFStringGetCString".}

proc getCStringPtr*(theString: CFStringRef, encoding: CFStringEncoding): cstring {.importc: "CFStringGetCStringPtr".}
proc getCharactersPtr*(theString: CFStringRef): cstring {.importc: "CFStringGetCharactersPtr".}
proc getBytes*(theString: CFStringRef, rng: CFRange, encoding: CFStringEncoding, lossByte: char, isExternalRepresentation: bool, buffer: pointer, maxBufLen: CFIndex, usedBufLen: ptr CFIndex): CFIndex {.importc: "CFStringGetBytes".}


proc getIntValue*(theString: CFStringRef): int32 {.importc: "CFStringGetIntValue".}
proc getDoubleValue*(theString: CFStringRef): cdouble {.importc: "CFStringGetDoubleValue".}

proc append*(theString: CFMutableStringRef, appendedString: CFStringRef) {.importc: "CFStringAppend".}

proc show*(obj: CFStringRef) {.importc: "CFShowStr".}

proc `$`*(s: CFStringRef): string =
    var ln: int
    let rng = cfRangeMake(0, s.len)
    discard getBytes(s, rng, kCFStringEncodingUTF8, '?', false, nil, 0, addr ln)
    result = newString(ln)
    if ln != 0:
        discard getBytes(s, rng, kCFStringEncodingUTF8, '?', false, addr(result[0]), ln, nil)


proc cfStringCreateWithCString*(alloc: CFAllocatorRef,str: cstring,encoding: CFStringEncoding): CFStringRef {.importc: "CFStringCreateWithCString"}

proc cfStringCreateUTF8WithCString*(str: cstring): CFStringRef =
    result = cfStringCreateWithCString(kCFAllocatorDefault, str, kCFStringEncodingUTF8)