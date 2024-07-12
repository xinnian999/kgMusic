import axios, { AxiosInstance, AxiosResponse, InternalAxiosRequestConfig } from "@ohos/axios";

const request: AxiosInstance = axios.create({
  baseURL: "http://101.42.108.39:3000",
  timeout: 3000
})

request.interceptors.request.use((req: InternalAxiosRequestConfig) => {
  const kgCookie = AppStorage.get<string>('kgCookie')
  req.headers.Cookie = kgCookie
  
  return req;
}, (err: Error) => {
  return err;
})

request.interceptors.response.use((res: AxiosResponse) => {

  if (res.config.url?.includes('/login/cellphone?')) {
    console.log(res.config.url)
    const cookies = (res.headers['set-cookie'] as string[]).map(item => item.split(';')[0]).join('; ')
    AppStorage.setOrCreate('kgCookie', cookies)
  }

  if (res.status === 200) {
    return res.data;
  }

  return Promise.reject(res);

}, (err: Error) => {
  return err;
})

export default request;