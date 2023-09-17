#ifndef FLUTTER_PLUGIN_WEEK_PICK_BUTTON_PLUGIN_H_
#define FLUTTER_PLUGIN_WEEK_PICK_BUTTON_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace week_pick_button {

class WeekPickButtonPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WeekPickButtonPlugin();

  virtual ~WeekPickButtonPlugin();

  // Disallow copy and assign.
  WeekPickButtonPlugin(const WeekPickButtonPlugin&) = delete;
  WeekPickButtonPlugin& operator=(const WeekPickButtonPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace week_pick_button

#endif  // FLUTTER_PLUGIN_WEEK_PICK_BUTTON_PLUGIN_H_
