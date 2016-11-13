module Main exposing (..)

import Html exposing (br, button, div, form, h1, input, label, li, strong, text, textarea, ul)
import Html.App
import Html.Attributes exposing(value)
import Html.Events exposing (onInput, onSubmit)

type alias Comment =
    { author : String
    , content : String
    }

type alias Model =
    { comments : List Comment
    , form : Comment
    }

initialModel : Model
initialModel =
    Model [] ( Comment "" "" )

type Msg 
    = PostComment
    | UpdateAuthor String
    | UpdateContent String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PostComment ->
            let
                model = 
                    { comments = List.append model.comments [ model.form ]
                    , form = Comment "" ""
                    }
            in
                ( model, Cmd.none )
        UpdateAuthor value ->
            ( { model | form = Comment value model.form.content }, Cmd.none )
        UpdateContent value ->
            ( { model | form = Comment model.form.author value }, Cmd.none )

pluralize : String -> Int -> String
pluralize name count = 
    if count == 1 then
        name
    else
        name ++ "s"

viewComment : Comment -> Html.Html Msg
viewComment comment =
    li
        []
        [ strong [] [ text comment.author ]
        , br [] []
        , text comment.content
        ]

view : Model -> Html.Html Msg
view model =
    let
        count =
            List.length model.comments
        title =
            (toString count) ++ (pluralize " Comment" count)
    in
        div
            []
            [ h1 [] [ title |> text ]
            , ul [] (List.map viewComment model.comments)
            , form
                [ onSubmit PostComment ]
                [ label [] [text "Name:"]
                , br [] []
                , input [ onInput UpdateAuthor, value model.form.author ] []
                , br [] []
                , label [] [text "Comment:"]
                , br [] []
                , textarea [ onInput UpdateContent, value model.form.content ] []
                , br [] []
                , button [] [ text "Send" ]
                ]
             , model |> toString |> text
            ]
main =
   Html.App.program
   { init = ( initialModel, Cmd.none )
   , update = update
   , subscriptions = (\n -> Sub.none)
   , view = view
   }
