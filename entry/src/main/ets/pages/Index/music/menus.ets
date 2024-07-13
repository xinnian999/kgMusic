export interface Item {
  title: string
  desc?: string
  bg: string
  to?: string
}

export default [
  {
    title: '猜你喜欢',
    desc: '',
    bg: '#ca1629',
  },

  {
    title: '排行榜', desc: '', bg: '#2c1e36'
  },

  {
    title: '听书', desc: '', bg: '#2c1e36'
  },
  {
    title: '歌手',
    desc: '',
    bg: '#7c1e36',
    to: "pages/Singer/index"
  },
  {
    title: '歌单', desc: '', bg: '#3d98ff'
  },

  {
    title: '分类', desc: '', bg: '#7c1e36'
  },

] as Item[]