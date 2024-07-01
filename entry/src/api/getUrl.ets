import { http } from '@kit.NetworkKit';

// 每一个httpRequest对应一个HTTP请求任务，不可复用
let httpRequest = http.createHttp();

const baseURL = 'http://localhost:3000'

export const getMusicUrlApi = (hash: string) => {
  const kgCookie = AppStorage.get<string>('kgCookie')

  return httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    `${baseURL}/song/url?hash=${hash}`, {
    header: {
      // Cookie: kgCookie
      // Cookie:'KUGOU_API_PLATFORM=lite;token=5d7e1fa1cff2a9961d6d79bb33d3bfa80a55267c848abe60bf28db1e786b2d25;userid=2228188622;vip_type=6;vip_token=1605f1613cb551c1644e693872124e91',
      Cookie:'BAIDUID_BFESS=C8D2CC5BE3B82E454E35B6593390D856:FG=1; BIDUPSID=DEA7E8E4CC8873BF9A942AA9629AB0C6; KUGOU_API_PLATFORM=lite; KugooID=678590584; UserName=kgopen678590584; ZFY=3lRRmf7cZwz0I2VtPdblpLxCDy4U52detptADrBwjHE:C; a_id=1014; dfid=2UHwEs3cFbda2D2ZGB3LeVBl; kg_dfid=2UHwEs3cFbda2D2ZGB3LeVBl; kg_dfid_collect=d41d8cd98f00b204e9800998ecf8427e; kg_mid=61738005f337b65eb31760f48a564449; mid=61738005f337b65eb31760f48a564449; musicwo17=kugou; t=fb27e534ea2693b26d6b571b3e38f46e91930c6a77b227d2ebf3dc7cd5a298dc; token=5d7e1fa1cff2a9961d6d79bb33d3bfa8fb3028434e1992c1cdb71696cb6075c2; userid=2228188622; vip_token=1605f1613cb551c1644e693872124e91; vip_type=6'
    }
  })
}



