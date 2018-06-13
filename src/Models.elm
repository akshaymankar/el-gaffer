module Models exposing (..)

import Date exposing (..)
import Dict exposing (..)
import Http exposing (..)


type alias TimesAndOwner =
    { since : Date, sinceStr : String, owner : LockOwner }


type alias Times =
    { since : Date, sinceStr : String }


type LockState
    = Unclaimed
    | Claimed TimesAndOwner
    | Recycling Times
    | WaitingToRecycle Times


type LockAction
    = Claim Pool Lock
    | Recycle Pool Lock
    | Unclaim Pool Lock
    | NoAction


type Route
    = RootRoute
    | GithubCallbackRoute String
    | AuthenticatedRoute String
    | NotFoundRoute


type LockOwner
    = Pipeline PipelineDetails
    | Committer String
    | GafferUser String


type alias PipelineDetails =
    { pipeline : String, job : String, buildNumber : Int }


type alias Lock =
    { name : String, state : LockState }


type alias Pool =
    String


type alias Pools =
    Dict Pool (List Lock)


type alias Flags =
    { backendUrl : String }


type alias Model =
    { flags : Flags, pools : Pools, loading : Bool, githubToken : Maybe String }


type Msg
    = NoOp
    | NewLocks (Result Http.Error Pools)
    | PerformLockAction LockAction
    | LockActionDone (Result Http.Error (List String))


type ErrorMessage
    = ErrorMessage String


initialModel : Model
initialModel =
    { flags = { backendUrl = "http://localhost:1000" }
    , pools = Dict.empty
    , loading = True
    , githubToken = Nothing
    }
