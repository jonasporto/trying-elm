module Main exposing (..)

import Html exposing (br, button, div, form, h1, input, label, li, strong, text, textarea, ul)
import Html.Attributes exposing (type')

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
    Model [] (Comment "" "")

pluralize : String -> Int -> String
pluralize name count = 
    if count == 1 then
        name
    else
        name ++ "s"

viewComment : Comment -> Html.Html msg
viewComment comment =
    li
        []
        [ strong [] [ text comment.author ]
        , br [] []
        , text comment.content
        ]

view : Model -> Html.Html msg
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
                []
                [ label [] [text "Name:"]
                , br [] []
                , input [] []
                , br [] []
                , label [] [text "Comment:"]
                , br [] []
                , textarea [] []
                , br [] []
                , button [ type' "submit" ] [ text "Send" ]
                ]
            ]
main =
   view initialModel  
