[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/gpl-2.0)
[![Tested On](https://img.shields.io/badge/Tested%20On-Gentoo-brightgreen)](https://github.com/Cosmic-AU/SetGPUFanCurve/issues)

README.MD

# SetGPUFanCurve.sh

## Purpose

A simple bash script for changing the fan curve and other settings on the AMD RX 7900 XTX.

I wrote this script to allow me to control the fan speed on my **Sapphire Nitro+ Radeon RX 7900 XTX 24GB GDDR6 Video Card** running on **Gentoo Linux**. It might be useful to others, so I threw it up here. If you want to change the various profile settings, the **PROFILE DEFINITIONS** section in the script should be fairly self-explanatory.

Free to use, copy, extend, fork, with attribution. Cheers! 🚀

## Requirements

- **OS**: Linux with the `amdgpu` kernel module (tested on Gentoo with kernel 6.15+).
- **Privileges**: Run as root (`sudo`).
- **AMD Overdrive**: Enable via kernel parameter `amdgpu.ppfeaturemask` (see **Important Note** below).
- **Dependencies**: None (pure bash; assumes `amdgpu` sysfs paths exist).

## Usage

```
▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜
▌╔════════════════════════════════════════════════════════════════════════════╗▐
▌║ Set GPU Fan Curve - Help                                                   ║▐
▌╚════════════════════════════════════════════════════════════════════════════╝▐
▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟
▌                                                                              ▐
▌ Usage:                                                                       ▐
▌                                                                              ▐
▌   sudo SetGPUFanCurve.sh [PROFILE]                                           ▐
▌                                                                              ▐
▌   PROFILE: Use one of the following fan curve profiles.                      ▐
▌            If omitted,'default' is used.                                     ▐
▌                                                                              ▐
▌ Available Profiles:                                                          ▐
▌                                                                              ▐
▌   default    - General purpose safe default (aggressive cooling, fans always ▐
▌                spin).                                                        ▐
▌   gaming     - For AAA gaming: Aggressive ramping to keep GPU cool,          ▐
▌                prioritizing temperature over noise/fan wear.                 ▐
▌   general    - For non-graphics tasks (e.g., email, coding): Balanced        ▐
▌                cooling with slightly quieter fans.                           ▐
▌   away       - For unattended/background tasks: Quiet optimization with      ▐
▌                zero-RPM mode enabled for silence when possible.              ▐
▌   ai         - For AI/ML/LLM tasks: Aggressive cooling for sustained high    ▐
▌                GPU loads.                                                    ▐
▌   current    - Display current GPU fan settings without making changes.      ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌ Examples:                                                                    ▐
▌                                                                              ▐
▌   sudo SetGPUFanCurve.sh gaming      # Apply gaming profile                  ▐
▌   sudo SetGPUFanCurve.sh away        # Apply away (quiet) profile            ▐
▌   sudo SetGPUFanCurve.sh             # Apply default profile                 ▐
▌                                                                              ▐
▌ This script configures AMD GPU fan parameters via sysfs (/sys/class/drm/     ▐
▌ card0/device/gpu_od/fan_ctrl). It requires root privileges and assumes       ▐
▌ the amdgpu kernel module with overdrive features enabled.                    ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌ Parameters Set:                                                              ▐
▌                                                                              ▐
▌   - fan_zero_rpm_enable: Enables/disables zero-RPM mode (0 or 1)             ▐
▌   - fan_minimum_pwm: Minimum fan speed % (15-100)                            ▐
▌   - fan_target_temperature: Base temp (°C) for curve activation              ▐
▌   - acoustic_limit_rpm_threshold: Max RPM cap for noise control              ▐
▌   - acoustic_target_rpm_threshold: Target RPM for quiet optimization         ▐
▌   - fan_curve: Multi-node Temperature-to-Fan Speed mapping                   ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌ Important Note:                                                              ▐
▌                                                                              ▐
▌   To use this script, AMD overdrive features must be enabled by setting      ▐
▌   amdgpu.ppfeaturemask in your GRUB kernel line (or whatever bootloader      ▐
▌   you're using). This enables fan curve control. Examples:                   ▐
▌                                                                              ▐
▌   amdgpu.ppfeaturemask=0xfffd7fff                                            ▐
▌   amdgpu.ppfeaturemask=0xffffffff                                            ▐
▌                                                                              ▐
▌   Full example:                                                              ▐
▌   linux /kernel-6.15.3-gentoo-EPC-hypervisor root=... init=...               ▐
▌   amdgpu.ppfeaturemask=0xfffd7fff                                            ▐
▌                                                                              ▐
▌   For more details, see AMD's official documentation:                        ▐
▌   https://docs.kernel.org/gpu/amdgpu/module-parameters.html#ppfeaturemask    ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌                   This script was written to control a                       ▐
▌          Sapphire Nitro+ Radeon RX 7900 XTX 24GB GDDR6 Video Card            ▐
▌      It may work on other similar cards but this has not been tested!        ▐
▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟
```

## Contributing / License

License: per GPL 2.0

Issues/PRs: Welcome! Open an issue on GitHub if you find bugs or have suggestions.

---

Script version: v1.0 (as of October 12, 2025)

Author: cosmic (Gentoo user)
