import request from './request'


export const sendCodeApi = (mobile: string) => {
  return request(
    `/captcha/sent?mobile=${mobile}`)
}

export const codeLoginApi = (mobile: string, code: string) => {
  return request(
    `/login/cellphone?mobile=${mobile}&code=${code}`)
}

export const loginApi = (username: string, password: string) => {
  return request(
    `/login?username=${username}&password=${password}`)
}

