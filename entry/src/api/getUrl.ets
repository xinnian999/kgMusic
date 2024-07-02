import { http } from '@kit.NetworkKit';

// 每一个httpRequest对应一个HTTP请求任务，不可复用
let httpRequest = http.createHttp();

const baseURL = 'http://localhost:3000'

export const getMusicUrlApi = (hash: string) => {
  const kgCookie = AppStorage.get<string>('kgCookie') ||
    'KUGOU_API_PLATFORM=undefined; token=fac4369eee51660f0dbca805a72892e88eeb83549c09074e0c7da2d2f7dd2d33; token=fac4369eee51660f0dbca805a72892e88eeb83549c09074e0c7da2d2f7dd2d33; userid=678590584; vip_type=6; vip_token=6623e7cc285f3950d7b93bd8a400691f'

  return httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    `${baseURL}/song/url?hash=${hash}&timestamp=${Date.now()}`, {
    header: {
      Cookie: kgCookie
    }
  })
}



