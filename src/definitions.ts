declare module '@capacitor/core' {
  interface PluginRegistry {
    FirebaseDynamicLinks: FirebaseDynamicLinksPlugin;
  }
}

export interface FirebaseDynamicLinksPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
