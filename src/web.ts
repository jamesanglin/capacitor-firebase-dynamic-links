import { WebPlugin } from '@capacitor/core';
import { FirebaseDynamicLinksPlugin } from './definitions';

export class FirebaseDynamicLinksWeb extends WebPlugin implements FirebaseDynamicLinksPlugin {
  constructor() {
    super({
      name: 'FirebaseDynamicLinks',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const FirebaseDynamicLinks = new FirebaseDynamicLinksWeb();

export { FirebaseDynamicLinks };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(FirebaseDynamicLinks);
