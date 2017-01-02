module Simperium.Messages where

import Prelude

import Data.Argonaut.Core (Json)
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

data AppMessage
    = ConnectToBucket ConnectionInfo BucketName AppMessage
    | RequestEntity Key EntityVersion
    | RequestChanges BucketVersion
    | RequestIndex BucketVersion Int
    | SendChange Key EntityVersion ChangeId Change
    | SendEntity Key EntityVersion Json

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

data Entity = Entity Key EntityVersion Json

data KeyVersionPair = KeyVersionPair Key EntityVersion