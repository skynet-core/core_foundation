{.passL: "-framework CoreFoundation"}

type
  Boolean* = uint8
  UniChar* = uint16
  CFTypeID* = distinct uint
  CFOptionFlags* = uint
  CFHashCode* = uint
  CFIndex* = int
  CFRange* = object
    location*: CFIndex
    length*: CFIndex
  CFTypeRef*{.pure, inheritable.} =  ptr object
  CFPropertyListRef* = ptr object of CFTypeRef
  CFAllocatorRef* = ptr object of CFTypeRef
  CFStringRef* = ptr object of CFPropertyListRef
  CFMutableStringRef* = ptr object of CFStringRef
  CFAbstractDictionaryRef* = ptr object of CFPropertyListRef # CFDictionary
  CFAbstractMutableDictionaryRef* = ptr object of CFAbstractDictionaryRef # CFMutableDictionary

proc show*(cf: CFTypeRef): void {.importc: "CFShow", nodecl.}
proc copyDescription*(cf: CFTypeRef): CFStringRef {.importc: "CFCopyDescription", nodecl.}
proc release*(cf: CFTypeRef): void {.importc: "CFRelease", nodecl.}
proc retain*(cf: CFTypeRef): void {.importc: "CFRetain", nodecl.}
proc cfRangeMake*(location, length: CFIndex): CFRange {.inline.} =
    result.location = location
    result.length = length


var
    allocDefault {.importc: "kCFAllocatorDefault".}: CFAllocatorRef
    allocSystemDefault {.importc: "kCFAllocatorSystemDefault".}: CFAllocatorRef
    allocMalloc {.importc: "kCFAllocatorMalloc".}: CFAllocatorRef
    allocMallocZone {.importc: "kCFAllocatorMallocZone".}: CFAllocatorRef
    allocNull {.importc: "kCFAllocatorNull".}: CFAllocatorRef
    allocUseContext {.importc: "kCFAllocatorUseContext".}: CFAllocatorRef


template kCFAllocatorDefault*: CFAllocatorRef =
    let a = allocDefault; a
template kCFAllocatorSystemDefault*: CFAllocatorRef =
    let a = allocSystemDefault; a
template kCFAllocatorMalloc*: CFAllocatorRef =
    let a = allocMalloc; a
template kCFAllocatorMallocZone*: CFAllocatorRef =
    let a = allocMallocZone; a
template kCFAllocatorNull*: CFAllocatorRef =
    let a = allocNull; a
template kCFAllocatorUseContext*: CFAllocatorRef =
    let a = allocUseContext; a


template toBool*(b: Boolean): bool = b == 0
template toBoolean*(b: bool): Boolean = Boolean(b)