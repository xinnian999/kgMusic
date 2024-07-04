import { http } from '@kit.NetworkKit';

// 每一个httpRequest对应一个HTTP请求任务，不可复用
let httpRequest = http.createHttp();

const baseURL = 'http://hyl999.co:3000'

export const sendCodeApi = (mobile: string) => {
  return httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    `${baseURL}/captcha/sent?mobile=${mobile}`)
}

export const codeLoginApi = (mobile: string, code: string) => {
  return httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    `${baseURL}/login/cellphone?mobile=${mobile}&code=${code}`)
}

export const loginApi = (username: string, password: string) => {
  return httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    `${baseURL}/login?username=${username}&password=${password}`)
}

