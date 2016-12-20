module StreamApi.Types where

data StreamAtom
    = ConnectToBucket 
    | ReceiveHeartbeat Int
    | SendHeartbeat Int