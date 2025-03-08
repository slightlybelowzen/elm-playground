module Main exposing (Model, Msg(..), init, main, update, view, viewInput, viewValidation)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "flex flex-col items-center gap-2 mx-auto max-w-3xl my-10 antialiased" ]
        [ div [ class "flex gap-2" ]
            [ viewInput "text" "Name" model.name Name
            , viewInput "password" "Password" model.password Password
            , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
            ]
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if String.isEmpty model.password then
        p [ class "text-red-800" ] [ text "Password cannot be empty." ]

    else if not (String.any Char.isDigit model.password) then
        p [ class "text-red-800" ] [ text "Password needs to contain uppercase, number, and lowercase letter." ]

    else if model.password == model.passwordAgain then
        p [ class "text-green-700" ] [ text "Looks good." ]

    else
        p [ class "text-red-800" ] [ text "Passwords do not match." ]
