
minsInSecs = 60
hoursInSecs = minsInSecs * 60

function timecodeToSecs(timecode) {
    return (timecode[0] * hoursInSecs) + (timecode[1] * minsInSecs) + timecode[2]
}
function secsToTimeCode(secs, timecode) {
    timecode[0] = int(secs/hoursInSecs)
    timecode[1] = int(secs/)
    # TODO complete
}
function extractTimecode(timecode) {
    match(timecode,(\d{2}):(\d{2}):(\d{2}), timecode)
}

BEGIN {
    transposeBy = ARGV[0]
}

{
    indexLine = match(timecode, /(\s*)INDEX (\d{2}) (\S*), lineData)
    if (indexLine) {
        whitespace = lineData[0]
        index = lineData[1]
        timecode = lineData[2]
    } else {
        # line doesn't match, pass-through
        printf $0
    }
}