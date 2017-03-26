module Expression where

import Data.Argonaut.Core (Json)
import Data.DateTime (DateTime)

import Simperium.Messages (Entity, EntityVersion, JsonDiff, Key)

data Expression
    = NoOp
    | ComputeDiff Json Json
    | GetEntity Key
    | GetLocalEntities Key
    | StoreEntity Entity
    | QueueChange Key EntityVersion Json DateTime
    | RebaseDiff Json JsonDiff JsonDiff 
    | RemoveEntity Key
    | RemoveLocalEntity Key
