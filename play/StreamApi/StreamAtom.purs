module StreamApi.StreamAtom where

import SimperiumTypes (Channel, AppMessage, ServerMessage)

data StreamAtom
    = ChannelCommand Channel AppMessage
    | ChannelMessage Channel ServerMessage
    | ReceiveHeartbeat Int
    | SendHeartbeat Int
    | StartLogging LoggingLevel
    | StopLogging

data LoggingLevel
    = NormalLogging
    | VerboseLogging
