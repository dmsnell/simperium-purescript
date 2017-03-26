module Expression where

import Data.Argonaut.Core (Json)
import Data.DateTime (DateTime)

import Types.Entity (Entity)
import Types.EntityVersion (EntityVersion)
import Types.Key (Key)
import Simperium.Messages (JsonDiff)

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
