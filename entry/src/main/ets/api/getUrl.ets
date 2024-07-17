import request from './request'

export const getMusicUrlApi = (hash: string) => {
  return request(
    `/song/url?hash=${hash}&timestamp=${Date.now()}`
  )
}


export const getLyricIdApi = (hash: string) => {
  return request(
    `/search/lyric?hash=${hash}&timestamp=${Date.now()}`
  )
}

export const getLyricApi = (id: string, accesskey: string) => {
  return request(
    `/lyric`, {
    params: {
      id,
      accesskey,
      decode: 'true',
      fmt: 'lrc'
    }
  }
  )
}