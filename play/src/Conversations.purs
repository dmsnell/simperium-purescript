module Conversations where

import Control.Bind (when)
import Data.Enum (downFrom)
import Data.Int.Bits (and)
import Data.Maybe (Maybe(..))
import Data.Newtype (over, overF)
import SimperiumTypes (ChangeError(..), Entity, JsonDiff, Message(..), StreamAtom)

updateEntity :: Entity -> JsonDiff -> Maybe Entity
updateEntity entity diff = Just entity

handleStreamAtom :: StreamAtom -> StreamAtom
handleStreamAtom 

handleMessage :: Message -> Maybe Command
handleMessage (AuthValid email) = do
    setClientState "email" email
    startPolling
    Nothing

handleMessage (AuthInvalid error message) = do
    announce "bad login" <> message

handleMessage (RecieveChanges changesets) = do
    applyChanges changesets

applyChange :: ChangeSet -> Maybe Command
applyChange (ChangeSet _ bucketVersion key start end change changeIds) = do
    case change of
        EntityDiff diff ->
            -- Either (Left NotFound) | (Right Entity)
            prev <- getEntity key start
            -- Either (Left InvalidDiff) | (Right Entity)
            next = map (applyDiff prev diff) prev
            storeEntity key end next

            {- 
            handle local queue
            iterate over staack and
            perform three-way reabase
            -}
            queued <- getQeuedEntities key start
            {-
            any one of these could fail when
            applying the diff rebase
            if that happens we need to notify
            the application and let it make a
            decision on what to do
            -}
            transformed = map rebase queued
            storeQueuedEntities transformed

        EntityRemoval ->
            removeEntity key

ReadEntity key version
ReadLatestEntity key
WriteEntity key version
ReadBucket name
