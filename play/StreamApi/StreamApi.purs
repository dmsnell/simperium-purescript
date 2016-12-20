module StreamApi where

class StreamApi a where
    fromStream :: StreamMessage -> a
    toStream :: a -> StreamMessage
