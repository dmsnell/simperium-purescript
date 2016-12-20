module StreamApi.StreamAtom where

import SimperiumTypes (Channel, Command, Message)

data StreamAtom
    = ChannelCommand Channel Command
    | ChannelMessage Channel Message
    | ReceiveHeartbeat Int
    | SendHeartbeat Int
    | StartLogging LoggingLevel
    | StopLogging

data LoggingLevel
    = NormalLogging
    | VerboseLogging

newtype StreamState = StreamState {
    channels : 
}