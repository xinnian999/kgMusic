import request from './request'

export const getMusicUrlApi = (hash: string) => {
  return request(
    `/song/url?hash=${hash}&timestamp=${Date.now()}`
  )
}



