module Simperium.Messages where

import Prelude

import Data.Argonaut.Core (Json)
import Data.Maybe (Maybe)
import Data.Monoid (class Monoid)

import Types.AppId (AppId)
import Types.AccessToken (AccessToken)
import Types.ApiVersion (ApiVersion)
import Types.BucketName (BucketName)
import Types.ClientId (ClientId)
import Types.ConnectionInfo (ConnectionInfo)
import Types.EntityVersion (EntityVersion)
import Types.Key (Key)
import Types.KeyVersionPair (KeyVersionPair)
import Types.LibraryName (LibraryName)
import Types.LibraryVersion (LibraryVersion)

newtype BucketVersion = Version String
newtype ChangeId = ChangeId UUID
newtype Channel = Channel Int
newtype EmailAddress = EmailAddress String
newtype JsonDiff = JsonDiff String
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

data ChangeSet =
    ChangeSet
        ClientId
        BucketVersion -- new bucket version after change
        Key
        EntityVersion -- start version of change
        EntityVersion -- end versio of change
        Change
        (Array ChangeId)

data Change
    = ModifyEntity JsonDiff
    | RemoveEntity
    | EmptyBucket
    | DropBucket
