#include "include/week_pick_button/week_pick_button_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "week_pick_button_plugin.h"

void WeekPickButtonPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  week_pick_button::WeekPickButtonPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
