import { http } from '@kit.NetworkKit';

// 每一个httpRequest对应一个HTTP请求任务，不可复用
let httpRequest = http.createHttp();

const baseURL = 'http://hyl999.co:3000'

export const getMusicUrlApi = (hash: string) => {
  const kgCookie = AppStorage.get<string>('kgCookie')

  console.log('kgCookie', kgCookie)

  return httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    `${baseURL}/song/url?hash=${hash}&timestamp=${Date.now()}`, {
    header: {
      Cookie: kgCookie
    }
  })
}



