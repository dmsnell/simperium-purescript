module SimperiumTypes where

import Prelude
import Data.Argonaut (class EncodeJson, Json, encodeJson, jsonEmptyObject, (~>), (:=))
import Data.Maybe (Maybe)
import Data.Monoid (class Monoid)

newtype AppId = AppId String
newtype AccessToken = AccessToken String
newtype ApiVersion = ApiVersion String
newtype BucketName = BucketName String
newtype BucketVersion = Version String
newtype ChangeId = ChangeId UUID
newtype Channel = Channel Int
newtype ClientId = ClientId String
newtype EmailAddress = EmailAddress String
newtype EntityVersion = EntityVersion Int
newtype JsonDiff = JsonDiff String
newtype Key = Key String
newtype LibraryName = LibraryName String
newtype LibraryVersion = LibraryVersion String
newtype UUID = UUID String

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

data AppMessage
    = ConnectToBucket ConnectionInfo BucketName Command
    | RequestEntity Key EntityVersion
    | RequestChanges BucketVersion
    | RequestIndex BucketVersion Int
    | SendChange Key EntityVersion ChangeId Change
    | SendEntity Key EntityVersion Json

instance streamApiCommand :: StreamApi Command where
    fromStream _ = NoOp

    toStream (ConnectToBucket connectionInfo (BucketName bucket) _) =
        StreamMessage $ "init:" <> (show $ encodeJson params)
            where
                params = "name" := bucket ~> connectionInfo

    toStream (RequestEntity (Key k) (EntityVersion v)) =
        StreamMessage $ "e:" <> k <> "." <> show v

    toStream _ = StreamMessage $ "NA"

data ServerMessage
    = AuthValid EmailAddress
    | AuthInvalid AuthError String
    | ChangeFailed Key ChangeError (Array ChangeId)
    | EntityNotFound Key EntityVersion
    | ReceiveChanges (Array ChangeSet)
    | ReceiveEntity Key EntityVersion Json
    | ReceiveIndex BucketVersion (Array KeyVersionPair) (Maybe BucketVersion)
    | VersionNotFound BucketVersion
    | UnknownMessage

instance streamApiMessage :: StreamApi Message where
    fromStream _ = UnknownMessage
    toStream a = StreamMessage "NA"

data AuthError
    = TokenFormatInvalid
    | TokenInvalid
    | UnspecifiedError

data ChangeError
    = DocumentTooLarge
    | DuplicateChange
    | EmptyChange
    | InternalServerError
    | InvalidDiff
    | InvalidEntity
    | InvalidIdOrSchema
    | InvalidPermissions
    | InvalidVersion

data ChangeSet = ChangeSet ClientId BucketVersion Key EntityVersion EntityVersion Change (Array ChangeId)

data Change
    = ModifyEntity JsonDiff
    | RemoveEntity
    | EmptyBucket
    | DropBucket

data ConnectionInfo = ConnectionInfo AppId AccessToken ApiVersion ClientId LibraryName LibraryVersion

instance encodeJson :: EncodeJson ConnectionInfo where
    encodeJson (ConnectionInfo (AppId a) (AccessToken t) (ApiVersion v) (ClientId c) (LibraryName ln) (LibraryVersion lv))
        = "app_id" := a
       ~> "token" := t
       ~> "api" := v
       ~> "client_id" := c
       ~> "library" := ln
       ~> "version" := lv
       ~> jsonEmptyObject

data Entity = Entity Key EntityVersion Json

data KeyVersionPair = KeyVersionPair Key EntityVersion