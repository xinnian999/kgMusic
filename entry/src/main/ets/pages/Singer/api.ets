import request from '../../api/request'

export const singerListApi = () => request('/artist/lists', { params: { pagesize: 50 } })

export const singerAudiosApi = (singerid: number) => request(`/artist/audios`, {
  params: {
    id: singerid,
    sort: 'hot'
  }
})

export const singerAlbumsApi = (singerid: number) => request(`/artist/albums`, {
  params: {
    id: singerid,
    pagesize: 500
  }
})