export interface LyricItem {
  lyric: string,
  timestamp: number,
  isCurrent?: boolean,

}

function parseLyric(lyricStr: string) {
  const lyricExp = /^\[(\d{2}):(\d{2}).(\d{1}|\d{2}|\d{3})\](.*)/;

  let lyricArr = lyricStr.split('\r\n').filter(item => item.match(lyricExp) !== null)

  return lyricArr.map(item => {
    const result = item.match(lyricExp)
    if (result) {
      const timestamp = Number(result[3]) + Number(result[2]) * 1000 + Number(result[1]) * 60 * 1000;

      return {
        lyric: result[4],
        timestamp
      } as LyricItem
    }
    return {
      lyric: item,
      timestamp: 0
    } as LyricItem
  })

}

export default parseLyric;