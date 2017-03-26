module Types.ClientId
    ( ClientId
    , clientId
    ) where

newtype ClientId = ClientId String

clientId :: ClientId
clientId = ClientId "simperium-purescript-0.1.0"