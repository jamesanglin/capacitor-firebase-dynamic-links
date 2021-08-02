import { WebPlugin } from '@capacitor/core';
import { CapacitorFirebaseDynamicLinksPlugin } from './definitions';

export class CapacitorFirebaseDynamicLinksWeb extends WebPlugin implements CapacitorFirebaseDynamicLinksPlugin {
  constructor() {
    super({
      name: 'CapacitorFirebaseDynamicLinks',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const CapacitorFirebaseDynamicLinks = new CapacitorFirebaseDynamicLinksWeb();

export { CapacitorFirebaseDynamicLinks };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(CapacitorFirebaseDynamicLinks);
