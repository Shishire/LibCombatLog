LibCombatLog is library that provides a callbackhandler based event interface for handling COMBAT_LOG_EVENTs.

You can Embed this Library in your addon, either by explicitly by calling LibCombatLog:Embed(yourAddon), or by specifying it as an embeded library via AceAddon.

It provides your addon with three new functions:
- MyAddon:RegisterCombatEvent(eventName, [callback])
- MyAddon:UnregisterCombatEvent(eventName)
- MyAddon:UnregisterAllCombatEvents()

These function identically to the AceEvent events, in that you should either have previously defined a properly named function for handling the events, or should manually specify which function to use.

The callback function should accept arguments according to CombatLogGetCurrentEventInfo(), except that arguments 1 (timestamp) and 2 (eventType) are swapped, so that the arguments go eventType, timestamp, ...

Exactly which arguments you should accept is dependent upon which eventType you have subscribed to.

To embed this library within your own, copy the LibCombatLog-1.0 folder to your addon's libs folder, and include the xml file in your embeds.xml.
