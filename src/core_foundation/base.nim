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
  CFTypeRef*{.pure, inheritable.} = ptr object
  CFPropertyListRef* = ptr object of CFTypeRef
  CFAllocatorRef* = ptr object of CFTypeRef
  CFStringRef* = ptr object of CFPropertyListRef
  CFMutableStringRef* = ptr object of CFStringRef
  CFAbstractDictionaryRef* = ptr object of CFPropertyListRef # CFDictionary
  CFAbstractMutableDictionaryRef* = ptr object of CFAbstractDictionaryRef # CFMutableDictionary

proc show*(cf: CFTypeRef): void {.importc: "CFShow", nodecl.}
proc copyDescription*(cf: CFTypeRef): CFStringRef {.importc: "CFCopyDescription", nodecl.}