import navConfig from './navConfig';
import Music from './music'
import My from './my'
import PlayBar from '../../components/PlayBar'
import { MusicPlayer } from '../../utils'
import { media } from '@kit.MediaKit';
import PlayBar2 from '../../components/PlayBar2';

PersistentStorage.persistProp('kgCookie', '12');
PersistentStorage.persistProp('userInfo', {});

@Entry
@Component
struct Index {
  @StorageLink('player') player: MusicPlayer | null = null;
  @State activeMenu: string = 'music'

  aboutToAppear(): void {
    this.player = new MusicPlayer()
  }

  build() {
    Column() {
      Navigation() {
        if (this.activeMenu === 'music') {
          Music()
        } else if (this.activeMenu === 'my') {
          My()
        }
        PlayBar2()

      }
      .padding({ top: 20 })
      .hideTitleBar(true)
      .width('100%')
      .mode(NavigationMode.Stack)
      .menus([
        {
          value: "", icon: "./image/ic_public_search.svg", action: () => {
        }
        },
        {
          value: "", icon: "./image/ic_public_add.svg", action: () => {
        }
        },

      ])
      .toolbarConfiguration(navConfig.map(item => ({
        'value': item.name,
        'icon': $r(`app.media.${item.key}`),
        'activeIcon': $r(`app.media.${item.key}`),
        status: this.activeMenu === item.key ? 2 : 0,
        'action': () => {
          this.activeMenu = item.key
        }
      } as ToolbarItem)))

    }

  }
}