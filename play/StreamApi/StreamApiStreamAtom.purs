module StreamApi.StreamApiStreamAtom where

instance streamApiStreamAtom :: StreamApi StreamAtom where
    fromStream _ = UnknownAtom

    toStream (ChannelCommand (Channel c) command) = 
        streamMessage <> channelMessage
            where
                streamMessage = StreamMessage $ (show c) <> ":"
                channelMessage = toStream command

    toStream (ChannelMessage (Channel c) message) = 
        streamMessage <> channelMessage
            where
                streamMessage = StreamMessage $ (show c) <> ":"
                channelMessage = toStream message
   
    toStream (ReceiveHeartbeat n) = StreamMessage ""
    toStream (SendHeartbeat n) = StreamMessage $ "h:" <> show n
    toStream (StartLogging Normal) = StreamMessage "log:1"
    toStream (StartLogging Verbose) = StreamMessage "log:2"
    toStream StopLogging = StreamMessage "log:0"
    toStream UnknownAtom = StreamMessage ""