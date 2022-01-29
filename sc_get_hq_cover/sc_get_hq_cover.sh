#!/usr/bin/env bash

# TODO implement more sophisticated strategy using `window.__sc_hydration` JSON

SC_COVERARTWORKURL_REGEX='https:\/\/[[:alnum:]]{2}\.sndcdn\.com\/artworks-[[:alnum:]]+-[[:alnum:]]+-([[:alnum:]]+).jpg'

curl -s "$1" |
    grep -oE "$SC_COVERARTWORKURL_REGEX" - | # extract all urls that look like coverarts
    head -n 1 | # only take the first match # TODO retry with other entries if curl fails at the end
    sed 's/-[[:alnum:]]*\.jpg$/-original.jpg/gm' | # fix path to get original source
    curl "$(cat)" # download coverart, taking url from stdin, outputting to stdout