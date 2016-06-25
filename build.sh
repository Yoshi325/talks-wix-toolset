#!/bin/bash

echo "Converting to reveal.js presentation..."
pandoc \
    outline.rst \
    --read=rst \
    --write=revealjs \
    --slide-level 1 \
    --variable theme="black" \
    --variable transition="fade" \
    --variable center="false" \
    --standalone \
  | tidy \
        -indent \
        -wrap 0 \
        -quiet \
        --doctype html5  \
        --indent-spaces 4 \
  | sed '/<\/head>/i \
            <style>   \
                .reveal .slides section .fragment.current-visible.current-fragment.collapsable-fragment { display: initial; } \
                .reveal .slides section .fragment.current-visible.collapsable-fragment { display: none; } \
                h1.subtitle { font-size: 2em; } \
                .code { text-align: left; } \
                .reveal dd > p { margin: 0; } \
                figure, img { border:none !important; outline: none !important; } \
                ul { columns: 2; -webkit-columns: 2; -moz-columns: 2; list-style-position: inside; } \
                li { white-space: nowrap; } \
            </style>  \
    ' \
  > index.html \
;

echo "Converting to pdf (via latex)..."
pandoc \
    outline.rst \
    --read=rst \
    --write=beamer \
    --slide-level 1 \
    --standalone \
    --output='talks-wix-toolset.pdf' \
;
