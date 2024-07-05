import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/welcome', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
      // AppStorage.setOrCreate('kgCookie',
      //   'KUGOU_API_PLATFORM=undefined; token=fac4369eee51660f0dbca805a72892e88eeb83549c09074e0c7da2d2f7dd2d33; token=fac4369eee51660f0dbca805a72892e88eeb83549c09074e0c7da2d2f7dd2d33; userid=678590584; vip_type=6; vip_token=6623e7cc285f3950d7b93bd8a400691f')
    });

    // windowStage.loadContent('pages/Login/index', (err) => {
    //   if (err.code) {
    //     return;
    //   }
    //   // AppStorage.setOrCreate('kgCookie',
    //   //   'KUGOU_API_PLATFORM=undefined; token=fac4369eee51660f0dbca805a72892e88eeb83549c09074e0c7da2d2f7dd2d33; token=fac4369eee51660f0dbca805a72892e88eeb83549c09074e0c7da2d2f7dd2d33; userid=678590584; vip_type=6; vip_token=6623e7cc285f3950d7b93bd8a400691f')
    // });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
