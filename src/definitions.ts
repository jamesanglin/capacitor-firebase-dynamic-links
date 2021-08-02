declare module '@capacitor/core' {
  interface PluginRegistry {
    CapacitorFirebaseDynamicLinks: CapacitorFirebaseDynamicLinksPlugin;
  }
}

export interface CapacitorFirebaseDynamicLinksPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
