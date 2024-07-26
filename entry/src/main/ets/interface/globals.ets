import { AudioRowItem } from './components'

export interface PlayData extends AudioRowItem {
  duration: number,
  lyric: string,
  avatar?: string
}

export const playDataInit: PlayData = {
  aid: 0,
  name: '歌名',
  author: '演唱者',
  albumId: 0,
  hash: '',
  avatar: '',
  lyric: '',
  duration: 0
}