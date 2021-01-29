# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

when isMainModule:
    import core_foundation/base 
    if true:
        var cf: CFTypeRef
    echo "done?"